"""Ties cache + Places/Weather/Geocode + search + LLM together per the
pipeline in SDD §3: cache-first, then parallel fetch of whatever's missing,
LLM only for the free-text fields, then write-through to cache.
"""
from __future__ import annotations

import asyncio
import logging
from datetime import datetime, timezone

from app.models.location import (
    API_ITEM_IDS,
    CHILD_IDS_BY_GROUP,
    CHILD_LABELS,
    LLM_ITEM_IDS,
    STATIC_ITEM_IDS,
    ChildItem,
    LocationInfo,
    LocationResponse,
    LocationSearchCandidate,
)
from app.models.settings import LLMRequestSettings
from app.services import cache, emergency, llm, places, search, timezone as timezone_service, weather
from app.services.llm import RateLimitExceeded

logger = logging.getLogger(__name__)


async def _fetch_api_item(item_id: str, location: LocationInfo) -> ChildItem | None:
    try:
        if item_id == "places":
            return await places.get_nearby_places(location.lat, location.lng)
        if item_id == "weather":
            return await weather.get_weather(location.lat, location.lng)
        if item_id == "airport":
            return await places.get_nearest_airport(location.lat, location.lng)
    except Exception:
        logger.exception("Failed to fetch API item %s for %s", item_id, location.id)
        return None
    return None


async def _fetch_llm_item(
    item_id: str, location: LocationInfo, settings: LLMRequestSettings
) -> ChildItem | None:
    query = llm.SEARCH_QUERY_TEMPLATES[item_id].format(name=location.name)
    try:
        results = await search.search(query)
    except Exception:
        logger.exception("Web search failed for item %s / %s", item_id, location.id)
        results = []

    if not settings.llm_enabled:
        if not results:
            return None
        sources = [r.url for r in results] if settings.show_sources else []
        return ChildItem(
            id=item_id,
            label=CHILD_LABELS[item_id],
            source="search",
            summary=results[0].title or results[0].snippet[:120],
            detail="\n\n".join(f"{r.title}: {r.snippet}" for r in results),
            sources=sources,
            updated_at=datetime.now(timezone.utc),
        )

    extra_context = ""
    if item_id == "health":
        try:
            extra_context = await places.get_nearest_hospital_snippet(location.lat, location.lng)
        except Exception:
            logger.exception("Hospital lookup failed for %s", location.id)

    try:
        return await llm.summarize_item(item_id, location.name, results, settings, extra_context)
    except RateLimitExceeded:
        logger.info("LLM rate limit hit for item %s, device %s", item_id, settings.device_id)
        return None
    except Exception:
        logger.exception("LLM summarization failed for item %s / %s", item_id, location.id)
        return None


async def _resolve_item(
    item_id: str,
    group_id: str,
    location: LocationInfo,
    settings: LLMRequestSettings,
    force_refresh: bool,
) -> None:
    """Fetch (if needed) and write-through one item to cache. Falls back to a
    stale cached value if a live refetch fails, per SDD 'cache-first'."""
    if not force_refresh:
        cached = cache.get_item(location.id, item_id)
        if cached is not None:
            return

    if item_id in API_ITEM_IDS:
        fresh = await _fetch_api_item(item_id, location)
    elif item_id in STATIC_ITEM_IDS:
        if item_id == "emergency":
            fresh = emergency.get_emergency_item(location.country_code)
        else:
            fresh = timezone_service.get_timezone_item(location.lat, location.lng)
    else:
        assert item_id in LLM_ITEM_IDS
        fresh = await _fetch_llm_item(item_id, location, settings)

    if fresh is not None:
        cache.put_item(location.id, group_id, fresh)
        return

    # Live fetch failed — keep serving a stale cached value if we have one.
    stale = cache.get_item_even_if_stale(location.id, item_id)
    if stale is not None and not force_refresh:
        cache.put_item(location.id, group_id, stale)


async def build_location_response(
    candidate: LocationSearchCandidate,
    settings: LLMRequestSettings,
    force_refresh_items: set[str] | None = None,
) -> LocationResponse:
    location = LocationInfo(
        id=candidate.location_id,
        name=candidate.name,
        lat=candidate.lat,
        lng=candidate.lng,
        country_code=candidate.country_code,
    )
    cache.upsert_location(location)

    force_refresh_items = force_refresh_items or set()
    tasks = []
    for group_id, child_ids in CHILD_IDS_BY_GROUP.items():
        for item_id in child_ids:
            tasks.append(
                _resolve_item(item_id, group_id, location, settings, item_id in force_refresh_items)
            )
    await asyncio.gather(*tasks)

    result = cache.get_full_location(location.id)
    if result is None:
        # Nothing could be fetched at all (e.g. no API keys configured, offline).
        result = LocationResponse(location=location, cached_at=datetime.now(timezone.utc), groups=[])
    return result
