"""Google Geocoding API — turns a free-text query into candidate locations.

Structured API only, never touches the LLM (SDD §3 principle: API-backed
items are parsed directly).
"""
from __future__ import annotations

import httpx

from app.config import get_settings
from app.models.location import LocationSearchCandidate
from app.services.cache import normalize_location_id

GEOCODE_URL = "https://maps.googleapis.com/maps/api/geocode/json"


def _country_code_from_components(components: list[dict]) -> str | None:
    for comp in components:
        if "country" in comp.get("types", []):
            return comp.get("short_name")
    return None


async def search_candidates(query: str) -> list[LocationSearchCandidate]:
    """Resolve a free-text query into one or more disambiguation candidates."""
    settings = get_settings()
    if not settings.google_places_api_key:
        raise RuntimeError("GOOGLE_PLACES_API_KEY is not configured")

    async with httpx.AsyncClient(timeout=settings.http_timeout_seconds) as client:
        resp = await client.get(
            GEOCODE_URL,
            params={"address": query, "key": settings.google_places_api_key},
        )
        resp.raise_for_status()
        data = resp.json()

    if data.get("status") not in ("OK", "ZERO_RESULTS"):
        raise RuntimeError(f"Geocoding failed: {data.get('status')} {data.get('error_message', '')}")

    candidates: list[LocationSearchCandidate] = []
    for result in data.get("results", []):
        loc = result["geometry"]["location"]
        lat, lng = loc["lat"], loc["lng"]
        candidates.append(
            LocationSearchCandidate(
                location_id=normalize_location_id(lat, lng),
                name=result.get("address_components", [{}])[0].get("long_name", query),
                formatted_address=result.get("formatted_address", query),
                lat=lat,
                lng=lng,
                country_code=_country_code_from_components(result.get("address_components", [])),
            )
        )
    return candidates
