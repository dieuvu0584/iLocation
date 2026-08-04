"""Environment configuration. See SDD §2/§7 and CLAUDE.md for provider choices.

Do not change default providers (Gemini Flash, Google Places, Tavily) without
checking with the project owner first — see CLAUDE.md "Việc KHÔNG được tự
quyết định".
"""
from functools import lru_cache
from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict

BASE_DIR = Path(__file__).resolve().parent.parent


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # --- Server ---
    app_env: str = "development"
    cors_origins: str = "*"

    # --- Storage ---
    sqlite_path: str = str(BASE_DIR / "data" / "cache.db")
    emergency_numbers_path: str = str(BASE_DIR / "data" / "emergency_numbers.json")

    # --- Google APIs (Places / Geocoding / Weather) ---
    google_places_api_key: str = ""
    weather_api_key: str = ""
    weather_provider: str = "openweathermap"  # openweathermap | weatherapi

    # --- Web search (LLM grounding) ---
    tavily_api_key: str = ""

    # --- LLM: free-tier default (app-owned key) ---
    gemini_api_key: str = ""
    gemini_model: str = "gemini-1.5-flash"
    llm_free_daily_limit_per_device: int = 30
    gemini_free_tier_daily_limit: int = 1500

    # --- Radius / misc ---
    nearby_places_radius_km: float = 15.0
    location_id_precision: int = 3  # decimal places used to round lat/lng for cache key

    # --- HTTP client ---
    http_timeout_seconds: float = 15.0


@lru_cache
def get_settings() -> Settings:
    return Settings()
