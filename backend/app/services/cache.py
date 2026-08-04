"""SQLite cache layer. Cache-first, per-item TTL (SDD §5) — do not use one
TTL for everything (see CLAUDE.md principle #3).

location_id is a normalized cache key: geocoded lat/lng rounded to
`location_id_precision` decimal places, so nearby repeat lookups collapse
into the same cache entry (SDD §5).
"""
from __future__ import annotations

import json
from datetime import datetime, timedelta, timezone

from app.config import get_settings
from app.db.database import get_connection
from app.models.location import ChildItem, Group, LocationInfo, LocationResponse

# TTL per item_id, per SDD §5. `None` means "no TTL" (static data, e.g. emergency).
TTL_BY_ITEM: dict[str, timedelta | None] = {
    # Weather: 3 hours
    "weather": timedelta(hours=3),
    # Nearby places / airport: 30 days
    "places": timedelta(days=30),
    "airport": timedelta(days=30),
    # Rarely-changing content: 90 days
    "food": timedelta(days=90),
    "best_time": timedelta(days=90),
    "language": timedelta(days=90),
    "etiquette": timedelta(days=90),
    "tipping": timedelta(days=90),
    "holidays": timedelta(days=90),
    "timezone": timedelta(days=90),
    # Needs-to-be-fresher content: 14 days
    "transport": timedelta(days=14),
    "power": timedelta(days=14),
    "currency": timedelta(days=14),
    "safety_level": timedelta(days=14),
    "health": timedelta(days=14),
    "water": timedelta(days=14),
    "insurance": timedelta(days=14),
    "visa": timedelta(days=14),
    "stay": timedelta(days=14),
    "cost": timedelta(days=14),
    # Static lookup table, never expires via TTL
    "emergency": None,
}

DEFAULT_TTL = timedelta(days=14)


def normalize_location_id(lat: float, lng: float) -> str:
    settings = get_settings()
    p = settings.location_id_precision
    return f"{round(lat, p):.{p}f}_{round(lng, p):.{p}f}"


def _expires_at(item_id: str, now: datetime) -> str | None:
    ttl = TTL_BY_ITEM.get(item_id, DEFAULT_TTL)
    if ttl is None:
        return None
    return (now + ttl).isoformat()


def upsert_location(location: LocationInfo) -> None:
    conn = get_connection()
    conn.execute(
        """
        INSERT INTO locations (location_id, name, lat, lng, country_code, created_at)
        VALUES (?, ?, ?, ?, ?, ?)
        ON CONFLICT(location_id) DO UPDATE SET
            name=excluded.name, lat=excluded.lat, lng=excluded.lng,
            country_code=excluded.country_code
        """,
        (
            location.id,
            location.name,
            location.lat,
            location.lng,
            location.country_code,
            datetime.now(timezone.utc).isoformat(),
        ),
    )
    conn.commit()


def get_location(location_id: str) -> LocationInfo | None:
    conn = get_connection()
    row = conn.execute(
        "SELECT * FROM locations WHERE location_id = ?", (location_id,)
    ).fetchone()
    if row is None:
        return None
    return LocationInfo(
        id=row["location_id"],
        name=row["name"],
        lat=row["lat"],
        lng=row["lng"],
        country_code=row["country_code"],
    )


def put_item(location_id: str, group_id: str, item: ChildItem) -> None:
    conn = get_connection()
    now = datetime.now(timezone.utc)
    conn.execute(
        """
        INSERT INTO cache_items
            (location_id, item_id, group_id, label, source, summary, detail,
             sources_json, warning, updated_at, expires_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(location_id, item_id) DO UPDATE SET
            group_id=excluded.group_id, label=excluded.label, source=excluded.source,
            summary=excluded.summary, detail=excluded.detail,
            sources_json=excluded.sources_json, warning=excluded.warning,
            updated_at=excluded.updated_at, expires_at=excluded.expires_at
        """,
        (
            location_id,
            item.id,
            group_id,
            item.label,
            item.source,
            item.summary,
            item.detail,
            json.dumps(item.sources),
            item.warning,
            item.updated_at.isoformat(),
            _expires_at(item.id, now),
        ),
    )
    conn.commit()


def _row_to_item(row) -> ChildItem:
    return ChildItem(
        id=row["item_id"],
        label=row["label"],
        source=row["source"],
        summary=row["summary"],
        detail=row["detail"],
        sources=json.loads(row["sources_json"]),
        warning=row["warning"],
        updated_at=datetime.fromisoformat(row["updated_at"]),
        is_stale=False,
    )


def get_item(location_id: str, item_id: str) -> ChildItem | None:
    """Return a cached item if present and not expired, else None."""
    conn = get_connection()
    row = conn.execute(
        "SELECT * FROM cache_items WHERE location_id = ? AND item_id = ?",
        (location_id, item_id),
    ).fetchone()
    if row is None:
        return None
    if row["expires_at"] is not None:
        expires_at = datetime.fromisoformat(row["expires_at"])
        if datetime.now(timezone.utc) >= expires_at:
            return None
    return _row_to_item(row)


def get_item_even_if_stale(location_id: str, item_id: str) -> ChildItem | None:
    """Used as a fallback when a live refetch fails — better a stale value than none."""
    conn = get_connection()
    row = conn.execute(
        "SELECT * FROM cache_items WHERE location_id = ? AND item_id = ?",
        (location_id, item_id),
    ).fetchone()
    if row is None:
        return None
    item = _row_to_item(row)
    if row["expires_at"] is not None:
        expires_at = datetime.fromisoformat(row["expires_at"])
        item.is_stale = datetime.now(timezone.utc) >= expires_at
    return item


def get_full_location(location_id: str) -> LocationResponse | None:
    """Assemble a LocationResponse from whatever is currently cached (may be partial)."""
    from app.models.location import CHILD_IDS_BY_GROUP, GROUP_LABELS

    location = get_location(location_id)
    if location is None:
        return None

    groups: list[Group] = []
    latest_cached_at = datetime.min.replace(tzinfo=timezone.utc)
    for group_id, child_ids in CHILD_IDS_BY_GROUP.items():
        children: list[ChildItem] = []
        for child_id in child_ids:
            item = get_item(location_id, child_id)
            if item is not None:
                children.append(item)
                latest_cached_at = max(latest_cached_at, item.updated_at)
        if children:
            groups.append(Group(id=group_id, label=GROUP_LABELS[group_id], children=children))

    if not groups:
        return None

    return LocationResponse(location=location, cached_at=latest_cached_at, groups=groups)


def delete_item(location_id: str, item_id: str) -> None:
    conn = get_connection()
    conn.execute(
        "DELETE FROM cache_items WHERE location_id = ? AND item_id = ?",
        (location_id, item_id),
    )
    conn.commit()


def delete_location(location_id: str) -> None:
    conn = get_connection()
    conn.execute("DELETE FROM cache_items WHERE location_id = ?", (location_id,))
    conn.execute("DELETE FROM locations WHERE location_id = ?", (location_id,))
    conn.commit()


def cache_stats() -> dict:
    conn = get_connection()
    locations = conn.execute("SELECT COUNT(*) AS c FROM locations").fetchone()["c"]
    items = conn.execute("SELECT COUNT(*) AS c FROM cache_items").fetchone()["c"]
    settings = get_settings()
    try:
        import os

        size_bytes = os.path.getsize(settings.sqlite_path)
    except OSError:
        size_bytes = 0
    return {"locations": locations, "items": items, "size_bytes": size_bytes}


def clear_all_cache() -> None:
    conn = get_connection()
    conn.execute("DELETE FROM cache_items")
    conn.execute("DELETE FROM locations")
    conn.commit()
