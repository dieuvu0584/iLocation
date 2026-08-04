import os
import tempfile

import pytest

os.environ.setdefault("GOOGLE_PLACES_API_KEY", "test-places-key")
os.environ.setdefault("WEATHER_API_KEY", "test-weather-key")
os.environ.setdefault("TAVILY_API_KEY", "test-tavily-key")
os.environ.setdefault("GEMINI_API_KEY", "test-gemini-key")


@pytest.fixture(autouse=True)
def fresh_db(monkeypatch, tmp_path):
    """Give every test an isolated SQLite DB so cache/rate-limit state never leaks."""
    from app.db import database

    db_path = tmp_path / "test_cache.db"
    database.reset_for_tests(str(db_path))
    yield
