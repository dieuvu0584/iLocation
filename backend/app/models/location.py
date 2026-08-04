"""Pydantic schemas mirroring SDD §4 JSON response schema.

Group/child ids are fixed by the SDD data model (2-tier: 5 groups, each with
a fixed set of children). Do not add/remove groups without updating the SDD.
"""
from __future__ import annotations

from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field

Source = Literal["api", "llm", "static", "search"]
"""api = structured API, llm = LLM-summarized, static = hardcoded lookup table,
search = raw web-search snippets shown as-is because the user disabled LLM."""

# Fixed group/child ids per SDD §4 — used for validation and TTL/LLM routing.
GROUP_IDS = ("explore", "practical", "safety", "culture", "entry_stay")

CHILD_IDS_BY_GROUP: dict[str, tuple[str, ...]] = {
    "explore": ("places", "food", "best_time"),
    "practical": ("weather", "transport", "power", "currency", "timezone"),
    "safety": ("safety_level", "health", "water", "insurance", "emergency"),
    "culture": ("language", "etiquette", "tipping", "holidays"),
    "entry_stay": ("visa", "airport", "stay", "cost"),
}

# Items backed directly by a structured API — never sent through the LLM.
API_ITEM_IDS = {"places", "weather", "airport"}
# Items computed/looked up without any external call — never sent through the LLM.
# `timezone` is computed from coordinates (SDD §4: "API/tĩnh theo toạ độ");
# `emergency` is a hardcoded per-country table (accuracy-critical, SDD §8).
STATIC_ITEM_IDS = {"emergency", "timezone"}
# Everything else is LLM-summarized from web search results.
LLM_ITEM_IDS = {
    child_id
    for children in CHILD_IDS_BY_GROUP.values()
    for child_id in children
    if child_id not in API_ITEM_IDS and child_id not in STATIC_ITEM_IDS
}

GROUP_LABELS = {
    "explore": "Explore",
    "practical": "Practical",
    "safety": "Safety & Health",
    "culture": "Culture",
    "entry_stay": "Entry & Stay",
}

CHILD_LABELS = {
    "places": "Nearby places",
    "food": "Local food",
    "best_time": "Best time to visit",
    "weather": "Weather",
    "transport": "Getting around",
    "power": "Power & SIM",
    "currency": "Currency & payments",
    "timezone": "Timezone",
    "safety_level": "Safety",
    "health": "Healthcare",
    "water": "Drinking water",
    "insurance": "Travel insurance",
    "emergency": "Emergency numbers",
    "language": "Language",
    "etiquette": "Etiquette",
    "tipping": "Tipping culture",
    "holidays": "Local holidays",
    "visa": "Visa",
    "airport": "Nearest airport",
    "stay": "Where to stay",
    "cost": "Cost of living",
}


class LocationInfo(BaseModel):
    id: str
    name: str
    lat: float
    lng: float
    country_code: str | None = Field(default=None, description="ISO 3166-1 alpha-2, used for emergency numbers")


class LocationSearchCandidate(BaseModel):
    """One disambiguation candidate returned by the geocoder for a free-text query."""

    location_id: str
    name: str
    formatted_address: str
    lat: float
    lng: float
    country_code: str | None = None


class ChildItem(BaseModel):
    id: str
    label: str
    source: Source
    summary: str
    detail: str = ""
    sources: list[str] = Field(default_factory=list)
    updated_at: datetime
    is_stale: bool = False
    warning: str | None = Field(
        default=None,
        description="Risk disclaimer, e.g. for visa — 'verify with official sources'",
    )


class Group(BaseModel):
    id: str
    label: str
    children: list[ChildItem]


class LocationResponse(BaseModel):
    location: LocationInfo
    cached_at: datetime
    groups: list[Group]
