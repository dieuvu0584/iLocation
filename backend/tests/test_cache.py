from datetime import datetime, timedelta, timezone

from app.db.database import get_connection
from app.models.location import ChildItem, LocationInfo
from app.services import cache


def test_normalize_location_id_rounds_and_collapses_nearby_points():
    a = cache.normalize_location_id(11.94041, 108.45831)
    b = cache.normalize_location_id(11.94039, 108.45829)
    assert a == b == "11.940_108.458"


def test_put_and_get_item_roundtrip():
    location = LocationInfo(id="loc1", name="Da Lat", lat=11.94, lng=108.46, country_code="VN")
    cache.upsert_location(location)
    item = ChildItem(
        id="weather",
        label="Weather",
        source="api",
        summary="18C",
        detail="clear",
        sources=[],
        updated_at=datetime.now(timezone.utc),
    )
    cache.put_item(location.id, "practical", item)

    fetched = cache.get_item(location.id, "weather")
    assert fetched is not None
    assert fetched.summary == "18C"
    assert fetched.source == "api"


def test_expired_item_is_not_returned_by_get_item():
    location = LocationInfo(id="loc2", name="Hanoi", lat=21.03, lng=105.85, country_code="VN")
    cache.upsert_location(location)
    item = ChildItem(
        id="weather",
        label="Weather",
        source="api",
        summary="25C",
        detail="",
        updated_at=datetime.now(timezone.utc),
    )
    cache.put_item(location.id, "practical", item)

    # Force-expire it directly (weather TTL is 3h — simulate time having passed).
    conn = get_connection()
    past = (datetime.now(timezone.utc) - timedelta(seconds=1)).isoformat()
    conn.execute(
        "UPDATE cache_items SET expires_at = ? WHERE location_id = ? AND item_id = ?",
        (past, location.id, "weather"),
    )
    conn.commit()

    assert cache.get_item(location.id, "weather") is None
    stale = cache.get_item_even_if_stale(location.id, "weather")
    assert stale is not None
    assert stale.is_stale is True


def test_emergency_item_has_no_ttl():
    assert cache.TTL_BY_ITEM["emergency"] is None


def test_cache_stats_and_clear():
    location = LocationInfo(id="loc3", name="Tokyo", lat=35.68, lng=139.69, country_code="JP")
    cache.upsert_location(location)
    item = ChildItem(
        id="weather", label="Weather", source="api", summary="s", detail="", updated_at=datetime.now(timezone.utc)
    )
    cache.put_item(location.id, "practical", item)

    stats = cache.cache_stats()
    assert stats["locations"] >= 1
    assert stats["items"] >= 1

    cache.clear_all_cache()
    stats_after = cache.cache_stats()
    assert stats_after["locations"] == 0
    assert stats_after["items"] == 0
