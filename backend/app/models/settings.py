"""Per-request settings the client sends (SDD §7.2).

BYOK API keys are transient: they arrive only in this request body, are used
to call the provider directly, and are never persisted or logged. See
CLAUDE.md principle #5 for the rationale.
"""
from __future__ import annotations

from typing import Literal

from pydantic import BaseModel, Field

ProviderMode = Literal["free", "byok"]
ByokProvider = Literal["gemini", "groq", "openrouter", "openai"]
DetailLevel = Literal["short", "detailed"]


class LLMRequestSettings(BaseModel):
    device_id: str = Field(..., description="Client-generated device identifier for free-tier rate limiting")
    llm_enabled: bool = True
    provider_mode: ProviderMode = "free"
    byok_provider: ByokProvider | None = None
    byok_api_key: str | None = Field(default=None, repr=False)
    fallback_enabled: bool = False
    detail_level: DetailLevel = "short"
    show_sources: bool = True
    content_language: str = Field(default="en", description="BCP-47 language code for LLM output content")

    def redacted(self) -> dict:
        """Safe-to-log representation with the API key stripped."""
        data = self.model_dump()
        if data.get("byok_api_key"):
            data["byok_api_key"] = "***"
        return data
