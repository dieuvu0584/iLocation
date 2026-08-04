"""Web search grounding for LLM-summarized fields (SDD §3, §10).

Provider: Tavily — chosen for its generous free tier and LLM/RAG-oriented
API. If this needs to change, update CLAUDE.md's "KHÔNG được tự quyết định"
note accordingly rather than swapping silently.
"""
from __future__ import annotations

from dataclasses import dataclass

import httpx

from app.config import get_settings

TAVILY_URL = "https://api.tavily.com/search"


@dataclass
class SearchResult:
    title: str
    url: str
    snippet: str


async def search(query: str, max_results: int = 5) -> list[SearchResult]:
    settings = get_settings()
    if not settings.tavily_api_key:
        raise RuntimeError("TAVILY_API_KEY is not configured")

    async with httpx.AsyncClient(timeout=settings.http_timeout_seconds) as client:
        resp = await client.post(
            TAVILY_URL,
            json={
                "api_key": settings.tavily_api_key,
                "query": query,
                "max_results": max_results,
                "search_depth": "basic",
            },
        )
        resp.raise_for_status()
        data = resp.json()

    return [
        SearchResult(
            title=r.get("title", ""),
            url=r.get("url", ""),
            snippet=r.get("content", ""),
        )
        for r in data.get("results", [])
    ]


def format_results_for_prompt(results: list[SearchResult]) -> str:
    if not results:
        return "(no search results found)"
    return "\n\n".join(f"[{i+1}] {r.title}\n{r.url}\n{r.snippet}" for i, r in enumerate(results))
