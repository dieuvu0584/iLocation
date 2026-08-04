from datetime import datetime, timezone

import pytest
from fastapi.testclient import TestClient

from app.main import app
from app.models.location import LocationInfo, LocationResponse, LocationSearchCandidate

client = TestClient(app)


def test_health():
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json() == {"status": "ok"}


def test_search_locations(monkeypatch):
    async def fake_search_candidates(query: str):
        return [
            LocationSearchCandidate(
                location_id="11.940_108.458",
                name="Da Lat",
                formatted_address="Da Lat, Vietnam",
                lat=11.94,
                lng=108.458,
                country_code="VN",
            )
        ]

    monkeypatch.setattr("app.services.geocode.search_candidates", fake_search_candidates)

    resp = client.post("/api/v1/locations/search", json={"query": "Da Lat"})
    assert resp.status_code == 200
    data = resp.json()
    assert data["candidates"][0]["location_id"] == "11.940_108.458"


def test_search_locations_rejects_empty_query():
    resp = client.post("/api/v1/locations/search", json={"query": "  "})
    assert resp.status_code == 400


def test_resolve_location(monkeypatch):
    async def fake_build_location_response(candidate, settings, force_refresh_items=None):
        return LocationResponse(
            location=LocationInfo(id=candidate.location_id, name=candidate.name, lat=candidate.lat, lng=candidate.lng),
            cached_at=datetime.now(timezone.utc),
            groups=[],
        )

    monkeypatch.setattr(
        "app.api.routes.location.build_location_response", fake_build_location_response
    )

    body = {
        "candidate": {
            "location_id": "11.940_108.458",
            "name": "Da Lat",
            "formatted_address": "Da Lat, Vietnam",
            "lat": 11.94,
            "lng": 108.458,
            "country_code": "VN",
        },
        "settings": {"device_id": "device-1"},
    }
    resp = client.post("/api/v1/locations/11.940_108.458", json=body)
    assert resp.status_code == 200
    assert resp.json()["location"]["name"] == "Da Lat"


def test_resolve_location_id_mismatch_rejected():
    body = {
        "candidate": {
            "location_id": "0.000_0.000",
            "name": "X",
            "formatted_address": "X",
            "lat": 0,
            "lng": 0,
        },
        "settings": {"device_id": "device-1"},
    }
    resp = client.post("/api/v1/locations/11.940_108.458", json=body)
    assert resp.status_code == 400


def test_llm_usage_endpoint():
    resp = client.get("/api/v1/llm/usage", params={"device_id": "device-1"})
    assert resp.status_code == 200
    assert "usage_today" in resp.json()


def test_cache_stats_and_clear_endpoints():
    resp = client.get("/api/v1/cache/stats")
    assert resp.status_code == 200
    resp = client.delete("/api/v1/cache")
    assert resp.status_code == 200
