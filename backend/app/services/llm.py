"""LLM aggregator: prompt building, provider routing, fallback (SDD §3-4, §7.2).

Only the 15 items in `LLM_ITEM_IDS` (app.models.location) ever reach this
module — Places/Weather/emergency are structured/static and must not be
routed through here (CLAUDE.md principle #1).

BYOK key handling: the key arrives only inside a single request's
`LLMRequestSettings`, is used for one outbound call to the provider, and is
never written to the DB or logs (CLAUDE.md principle #5). We route BYOK
calls through the backend — rather than having the Flutter client call LLM
providers directly — so prompt-building, JSON-schema enforcement, and
localization stay in one place instead of being duplicated in Dart. If this
changes, update this note.
"""
from __future__ import annotations

import json
import re
from datetime import datetime, timezone

import httpx

from app.config import get_settings
from app.models.location import CHILD_LABELS, ChildItem
from app.models.settings import LLMRequestSettings
from app.services import rate_limit
from app.services.search import SearchResult, format_results_for_prompt

# Item-specific web search query templates (SDD §10 groundwork for search.py).
SEARCH_QUERY_TEMPLATES: dict[str, str] = {
    "food": "{name} local food specialties must-try dishes",
    "best_time": "{name} best time to visit weather by season",
    "transport": "{name} public transportation getting around guide for tourists",
    "power": "{name} power plug type voltage SIM card eSIM for travelers",
    "currency": "{name} currency cash vs card payment tips for tourists",
    "safety_level": "{name} travel safety advisory common scams crime",
    "health": "{name} healthcare quality for tourists travel clinic",
    "water": "{name} tap water safe to drink",
    "insurance": "{name} travel insurance requirement recommendation",
    "language": "{name} official language spoken english proficiency",
    "etiquette": "{name} local customs etiquette dos and don'ts for tourists",
    "tipping": "{name} tipping culture custom restaurants taxis",
    "holidays": "{name} public holidays festivals calendar",
    "visa": "{name} visa requirements for tourists entry rules",
    "stay": "{name} best areas neighborhoods to stay for tourists",
    "cost": "{name} daily travel budget cost of living for tourists",
}

# Items where getting it wrong is high-stakes — always append a disclaimer
# regardless of what the LLM produced (SDD §8).
RISK_DISCLAIMER_ITEMS: dict[str, str] = {
    "visa": "Visa rules change often and vary by nationality — verify with the destination's official immigration/embassy website before travel.",
    "insurance": "Coverage requirements vary by nationality and visa type — verify with your insurer and destination's official sources.",
}

PROVIDER_ENDPOINTS = {
    "groq": "https://api.groq.com/openai/v1/chat/completions",
    "openrouter": "https://openrouter.ai/api/v1/chat/completions",
    "openai": "https://api.openai.com/v1/chat/completions",
}

PROVIDER_DEFAULT_MODELS = {
    "groq": "llama-3.1-8b-instant",
    "openrouter": "openai/gpt-4o-mini",
    "openai": "gpt-4o-mini",
}


class LLMError(RuntimeError):
    pass


class RateLimitExceeded(LLMError):
    pass


def _build_prompt(
    item_id: str,
    location_name: str,
    search_results: list[SearchResult],
    detail_level: str,
    content_language: str,
) -> str:
    label = CHILD_LABELS[item_id]
    length_hint = (
        "1-2 short sentences for the summary, and a short paragraph (3-5 sentences) for detail"
        if detail_level == "short"
        else "1-2 sentences for the summary, and a thorough multi-paragraph write-up for detail"
    )
    return f"""You are summarizing travel information about "{location_name}" for the
topic "{label}". Use ONLY the search results below as your source of truth;
if they don't cover the topic, say so honestly instead of inventing facts.

Search results:
{format_results_for_prompt(search_results)}

Write your answer in language code "{content_language}".
Respond with ONLY a JSON object, no markdown fences, matching exactly:
{{"summary": "...", "detail": "..."}}
Length: {length_hint}.
"""


def _extract_json(text: str) -> dict:
    match = re.search(r"\{.*\}", text, re.DOTALL)
    if not match:
        raise LLMError(f"LLM response did not contain JSON: {text[:200]}")
    return json.loads(match.group(0))


async def _call_gemini(api_key: str, model: str, prompt: str, timeout: float) -> str:
    url = f"https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent?key={api_key}"
    async with httpx.AsyncClient(timeout=timeout) as client:
        resp = await client.post(url, json={"contents": [{"parts": [{"text": prompt}]}]})
        if resp.status_code == 429:
            raise RateLimitExceeded("Gemini rate limit exceeded")
        resp.raise_for_status()
        data = resp.json()
    try:
        return data["candidates"][0]["content"]["parts"][0]["text"]
    except (KeyError, IndexError) as exc:
        raise LLMError(f"Unexpected Gemini response shape: {data}") from exc


async def _call_openai_compatible(
    provider: str, api_key: str, model: str, prompt: str, timeout: float
) -> str:
    url = PROVIDER_ENDPOINTS[provider]
    headers = {"Authorization": f"Bearer {api_key}"}
    async with httpx.AsyncClient(timeout=timeout) as client:
        resp = await client.post(
            url,
            headers=headers,
            json={
                "model": model,
                "messages": [{"role": "user", "content": prompt}],
                "temperature": 0.3,
            },
        )
        if resp.status_code == 429:
            raise RateLimitExceeded(f"{provider} rate limit exceeded")
        resp.raise_for_status()
        data = resp.json()
    try:
        return data["choices"][0]["message"]["content"]
    except (KeyError, IndexError) as exc:
        raise LLMError(f"Unexpected {provider} response shape: {data}") from exc


async def _call_provider(provider: str, api_key: str, model: str, prompt: str) -> str:
    settings = get_settings()
    if provider == "gemini":
        return await _call_gemini(api_key, model, prompt, settings.http_timeout_seconds)
    if provider in PROVIDER_ENDPOINTS:
        return await _call_openai_compatible(provider, api_key, model, prompt, settings.http_timeout_seconds)
    raise LLMError(f"Unknown provider: {provider}")


async def summarize_item(
    item_id: str,
    location_name: str,
    search_results: list[SearchResult],
    request_settings: LLMRequestSettings,
    extra_context: str = "",
) -> ChildItem:
    """Summarize one LLM-backed item. Raises LLMError/RateLimitExceeded on failure."""
    settings = get_settings()
    prompt = _build_prompt(
        item_id, location_name, search_results, request_settings.detail_level, request_settings.content_language
    )
    if extra_context:
        prompt += f"\n\nAdditional structured data to ground your answer:\n{extra_context}\n"

    if request_settings.provider_mode == "byok":
        if not request_settings.byok_provider or not request_settings.byok_api_key:
            raise LLMError("BYOK mode requires byok_provider and byok_api_key")
        provider = request_settings.byok_provider
        model = PROVIDER_DEFAULT_MODELS.get(provider, "gemini-1.5-flash")
        try:
            raw = await _call_provider(provider, request_settings.byok_api_key, model, prompt)
        except RateLimitExceeded:
            if not request_settings.fallback_enabled:
                raise
            # Fall back to the app's own free-tier key (still subject to its limit).
            raw = await _summarize_with_free_tier(request_settings.device_id, prompt)
    else:
        raw = await _summarize_with_free_tier(request_settings.device_id, prompt)

    parsed = _extract_json(raw)
    sources = [r.url for r in search_results] if request_settings.show_sources else []

    return ChildItem(
        id=item_id,
        label=CHILD_LABELS[item_id],
        source="llm",
        summary=parsed.get("summary", "").strip(),
        detail=parsed.get("detail", "").strip(),
        sources=sources,
        updated_at=datetime.now(timezone.utc),
        warning=RISK_DISCLAIMER_ITEMS.get(item_id),
    )


async def _summarize_with_free_tier(device_id: str, prompt: str) -> str:
    settings = get_settings()
    if not settings.gemini_api_key:
        raise LLMError("GEMINI_API_KEY is not configured for free-tier use")

    allowed, _usage, _limit = rate_limit.can_use_free_tier(device_id)
    if not allowed:
        raise RateLimitExceeded("Free-tier daily limit reached for this device")

    raw = await _call_gemini(settings.gemini_api_key, settings.gemini_model, prompt, settings.http_timeout_seconds)
    rate_limit.record_free_tier_use(device_id)
    return raw
