"""OpenWeatherMap integration — structured API, never touches the LLM."""
from __future__ import annotations

from datetime import datetime, timezone

import httpx

from app.config import get_settings
from app.models.location import ChildItem

CURRENT_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"


async def get_weather(lat: float, lng: float) -> ChildItem:
    settings = get_settings()
    if not settings.weather_api_key:
        raise RuntimeError("WEATHER_API_KEY is not configured")

    async with httpx.AsyncClient(timeout=settings.http_timeout_seconds) as client:
        resp = await client.get(
            CURRENT_WEATHER_URL,
            params={
                "lat": lat,
                "lon": lng,
                "appid": settings.weather_api_key,
                "units": "metric",
            },
        )
        resp.raise_for_status()
        data = resp.json()

    temp_c = data.get("main", {}).get("temp")
    feels_like = data.get("main", {}).get("feels_like")
    condition = (data.get("weather") or [{}])[0].get("description", "unknown")
    humidity = data.get("main", {}).get("humidity")
    wind = data.get("wind", {}).get("speed")

    summary = f"{temp_c:.0f}°C, {condition}" if temp_c is not None else condition
    detail = (
        f"Feels like {feels_like:.0f}°C, humidity {humidity}%, wind {wind} m/s"
        if feels_like is not None
        else ""
    )

    return ChildItem(
        id="weather",
        label="Weather",
        source="api",
        summary=summary,
        detail=detail,
        sources=[],
        updated_at=datetime.now(timezone.utc),
    )
