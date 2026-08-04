from __future__ import annotations

from fastapi import APIRouter

from app.services import cache as cache_service
from app.services import rate_limit

router = APIRouter(prefix="/api/v1", tags=["meta"])


@router.get("/llm/usage")
async def llm_usage(device_id: str) -> dict:
    return rate_limit.usage_snapshot(device_id)


@router.get("/cache/stats")
async def cache_stats() -> dict:
    return cache_service.cache_stats()


@router.delete("/cache")
async def clear_cache() -> dict:
    cache_service.clear_all_cache()
    return {"status": "cleared"}
