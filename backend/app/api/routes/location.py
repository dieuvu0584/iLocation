from __future__ import annotations

from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel

from app.models.location import CHILD_IDS_BY_GROUP, LocationResponse, LocationSearchCandidate
from app.models.settings import LLMRequestSettings
from app.services import geocode
from app.services.orchestrator import build_location_response

router = APIRouter(prefix="/api/v1/locations", tags=["locations"])


class SearchRequest(BaseModel):
    query: str


class SearchResponse(BaseModel):
    candidates: list[LocationSearchCandidate]


class ResolveRequest(BaseModel):
    candidate: LocationSearchCandidate
    settings: LLMRequestSettings


@router.post("/search", response_model=SearchResponse)
async def search_locations(body: SearchRequest) -> SearchResponse:
    if not body.query.strip():
        raise HTTPException(status_code=400, detail="query must not be empty")
    try:
        candidates = await geocode.search_candidates(body.query)
    except RuntimeError as exc:
        raise HTTPException(status_code=502, detail=str(exc)) from exc
    return SearchResponse(candidates=candidates)


@router.post("/{location_id}", response_model=LocationResponse)
async def resolve_location(location_id: str, body: ResolveRequest) -> LocationResponse:
    if body.candidate.location_id != location_id:
        raise HTTPException(status_code=400, detail="location_id path/body mismatch")
    return await build_location_response(body.candidate, body.settings)


@router.post("/{location_id}/refresh", response_model=LocationResponse)
async def refresh_location(
    location_id: str,
    body: ResolveRequest,
    item_id: str | None = Query(default=None, description="Refresh only this item; omit to refresh everything"),
) -> LocationResponse:
    if body.candidate.location_id != location_id:
        raise HTTPException(status_code=400, detail="location_id path/body mismatch")
    if item_id:
        force_refresh_items = {item_id}
    else:
        force_refresh_items = {i for ids in CHILD_IDS_BY_GROUP.values() for i in ids}
    return await build_location_response(body.candidate, body.settings, force_refresh_items=force_refresh_items)
