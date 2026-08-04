"""Timezone lookup computed from coordinates (SDD §4: "API/tĩnh theo toạ độ").

No external API call — resolved locally via timezonefinder + stdlib zoneinfo,
so this item is free and never touches the LLM.
"""
from __future__ import annotations

from datetime import datetime, timezone as dt_timezone
from functools import lru_cache
from zoneinfo import ZoneInfo

from timezonefinder import TimezoneFinder

from app.models.location import ChildItem


@lru_cache
def _finder() -> TimezoneFinder:
    return TimezoneFinder()


def get_timezone_item(lat: float, lng: float) -> ChildItem:
    tz_name = _finder().timezone_at(lat=lat, lng=lng)
    now = datetime.now(dt_timezone.utc)

    if tz_name is None:
        return ChildItem(
            id="timezone",
            label="Timezone",
            source="static",
            summary="Unknown (over international waters or unmapped area)",
            detail="",
            updated_at=now,
        )

    local_now = now.astimezone(ZoneInfo(tz_name))
    offset = local_now.utcoffset()
    total_minutes = int(offset.total_seconds() // 60) if offset else 0
    sign = "+" if total_minutes >= 0 else "-"
    hh, mm = divmod(abs(total_minutes), 60)
    offset_str = f"UTC{sign}{hh:02d}:{mm:02d}"

    return ChildItem(
        id="timezone",
        label="Timezone",
        source="static",
        summary=f"{tz_name} ({offset_str})",
        detail=f"Local time now: {local_now.strftime('%Y-%m-%d %H:%M')}",
        updated_at=now,
    )
