"""Per-device daily rate limiting for the free-tier LLM (CLAUDE.md principle #4).

Only applies to `provider_mode="free"` (the app's own Gemini key). BYOK calls
are unlimited from the app's perspective — the user pays their own provider.
"""
from __future__ import annotations

from datetime import date, datetime, timedelta, timezone

from app.config import get_settings
from app.db.database import get_connection


def _today() -> str:
    return date.today().isoformat()


def get_device_usage(device_id: str) -> int:
    conn = get_connection()
    row = conn.execute(
        "SELECT count FROM device_llm_usage WHERE device_id = ? AND usage_date = ?",
        (device_id, _today()),
    ).fetchone()
    return row["count"] if row else 0


def get_app_usage() -> int:
    conn = get_connection()
    row = conn.execute(
        "SELECT count FROM app_llm_usage WHERE usage_date = ?", (_today(),)
    ).fetchone()
    return row["count"] if row else 0


def can_use_free_tier(device_id: str) -> tuple[bool, int, int]:
    """Returns (allowed, usage_today, device_limit)."""
    settings = get_settings()
    device_usage = get_device_usage(device_id)
    app_usage = get_app_usage()
    allowed = device_usage < settings.llm_free_daily_limit_per_device and (
        app_usage < settings.gemini_free_tier_daily_limit
    )
    return allowed, device_usage, settings.llm_free_daily_limit_per_device


def record_free_tier_use(device_id: str) -> None:
    conn = get_connection()
    today = _today()
    conn.execute(
        """
        INSERT INTO device_llm_usage (device_id, usage_date, count)
        VALUES (?, ?, 1)
        ON CONFLICT(device_id, usage_date) DO UPDATE SET count = count + 1
        """,
        (device_id, today),
    )
    conn.execute(
        """
        INSERT INTO app_llm_usage (usage_date, count)
        VALUES (?, 1)
        ON CONFLICT(usage_date) DO UPDATE SET count = count + 1
        """,
        (today,),
    )
    conn.commit()


def usage_snapshot(device_id: str) -> dict:
    settings = get_settings()
    tomorrow_midnight_utc = datetime.combine(
        date.today() + timedelta(days=1), datetime.min.time(), tzinfo=timezone.utc
    )
    return {
        "usage_today": get_device_usage(device_id),
        "limit": settings.llm_free_daily_limit_per_device,
        "reset_at": tomorrow_midnight_utc.isoformat(),
    }
