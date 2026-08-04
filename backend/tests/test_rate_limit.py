from app.config import get_settings
from app.services import rate_limit


def test_free_tier_allows_then_blocks_after_limit(monkeypatch):
    monkeypatch.setenv("LLM_FREE_DAILY_LIMIT_PER_DEVICE", "2")
    get_settings.cache_clear()
    try:
        device_id = "device-abc"

        allowed, usage, limit = rate_limit.can_use_free_tier(device_id)
        assert allowed is True
        assert usage == 0
        assert limit == 2

        rate_limit.record_free_tier_use(device_id)
        allowed, usage, _ = rate_limit.can_use_free_tier(device_id)
        assert allowed is True
        assert usage == 1

        rate_limit.record_free_tier_use(device_id)
        allowed, usage, _ = rate_limit.can_use_free_tier(device_id)
        assert allowed is False
        assert usage == 2
    finally:
        get_settings.cache_clear()


def test_usage_is_isolated_per_device(monkeypatch):
    monkeypatch.setenv("LLM_FREE_DAILY_LIMIT_PER_DEVICE", "5")
    get_settings.cache_clear()
    try:
        rate_limit.record_free_tier_use("device-1")
        assert rate_limit.get_device_usage("device-1") == 1
        assert rate_limit.get_device_usage("device-2") == 0
    finally:
        get_settings.cache_clear()


def test_usage_snapshot_shape():
    snap = rate_limit.usage_snapshot("device-x")
    assert set(snap.keys()) == {"usage_today", "limit", "reset_at"}
