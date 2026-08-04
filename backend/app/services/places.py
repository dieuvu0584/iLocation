"""Google Places API — nearby places, nearest airport, nearest hospital.

Structured API only, never touches the LLM.
"""
from __future__ import annotations

from datetime import datetime, timezone

import httpx

from app.config import get_settings
from app.models.location import ChildItem

NEARBY_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"


async def _nearby_search(lat: float, lng: float, place_type: str, radius_m: int) -> list[dict]:
    settings = get_settings()
    if not settings.google_places_api_key:
        raise RuntimeError("GOOGLE_PLACES_API_KEY is not configured")

    async with httpx.AsyncClient(timeout=settings.http_timeout_seconds) as client:
        resp = await client.get(
            NEARBY_SEARCH_URL,
            params={
                "location": f"{lat},{lng}",
                "radius": radius_m,
                "type": place_type,
                "key": settings.google_places_api_key,
            },
        )
        resp.raise_for_status()
        data = resp.json()

    if data.get("status") not in ("OK", "ZERO_RESULTS"):
        raise RuntimeError(f"Places search failed: {data.get('status')} {data.get('error_message', '')}")
    return data.get("results", [])


async def get_nearby_places(lat: float, lng: float) -> ChildItem:
    settings = get_settings()
    radius_m = int(settings.nearby_places_radius_km * 1000)
    results = await _nearby_search(lat, lng, "point_of_interest", radius_m)
    top = results[:10]
    names = [r["name"] for r in top]
    summary = f"{len(results)} places nearby" if results else "No notable places found nearby"
    detail = "\n".join(
        f"- {r['name']} ({r.get('rating', 'n/a')}★) — {r.get('vicinity', '')}" for r in top
    )
    return ChildItem(
        id="places",
        label="Nearby places",
        source="api",
        summary=summary,
        detail=detail or "No data available.",
        sources=[],
        updated_at=datetime.now(timezone.utc),
    )


async def get_nearest_airport(lat: float, lng: float) -> ChildItem:
    results = await _nearby_search(lat, lng, "airport", 100_000)
    if not results:
        return ChildItem(
            id="airport",
            label="Nearest airport",
            source="api",
            summary="No airport found within 100km",
            detail="",
            updated_at=datetime.now(timezone.utc),
        )
    nearest = results[0]
    summary = nearest["name"]
    detail = nearest.get("vicinity", "")
    return ChildItem(
        id="airport",
        label="Nearest airport",
        source="api",
        summary=summary,
        detail=detail,
        updated_at=datetime.now(timezone.utc),
    )


async def get_nearest_hospital_snippet(lat: float, lng: float) -> str:
    """Raw snippet used as an input to the LLM-summarized `health` item (SDD §4:
    health = API Places + LLM — the API result grounds the LLM summary)."""
    results = await _nearby_search(lat, lng, "hospital", 15_000)
    if not results:
        return "No hospital found within 15km (structured data)."
    lines = [f"{r['name']} — {r.get('vicinity', '')}" for r in results[:5]]
    return "Nearby hospitals (structured data):\n" + "\n".join(lines)
