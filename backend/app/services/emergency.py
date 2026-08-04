"""Static emergency-number lookup by country code (SDD §4/§8: emergency
numbers must NOT be LLM-generated — accuracy risk is too high).

No TTL — this table is updated manually, not refetched (SDD §5).
"""
from __future__ import annotations

import json
from datetime import datetime, timezone
from functools import lru_cache

from app.config import get_settings
from app.models.location import ChildItem


@lru_cache
def _load_table() -> dict:
    settings = get_settings()
    with open(settings.emergency_numbers_path, encoding="utf-8") as f:
        return json.load(f)


def get_emergency_item(country_code: str | None) -> ChildItem:
    table = _load_table()
    entry = table.get((country_code or "").upper()) or table["_default"]
    is_fallback = (country_code or "").upper() not in table

    numbers = [f"Police: {entry['police']}", f"Ambulance: {entry['ambulance']}", f"Fire: {entry['fire']}"]
    summary = f"General emergency: {entry['general']}"
    detail = " · ".join(numbers)
    warning = entry.get("note") if is_fallback else None

    return ChildItem(
        id="emergency",
        label="Emergency numbers",
        source="static",
        summary=summary,
        detail=detail,
        sources=[],
        updated_at=datetime.now(timezone.utc),
        warning=warning,
    )
