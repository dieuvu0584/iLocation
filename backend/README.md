# Location Info Explorer — Backend

FastAPI backend implementing the pipeline described in `SDD.md` §3: cache-first,
then parallel Places/Weather/timezone/emergency-table lookups plus web-search +
LLM summarization for the remaining free-text fields.

## Run locally

```bash
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # fill in API keys
uvicorn app.main:app --reload
```

Without any API keys configured, the server still starts; endpoints that need
a given provider return `502` for that call. Fill in `.env` incrementally as
you get keys for Google Places/Geocoding, OpenWeatherMap, Tavily, and Gemini.

## Run with Docker

```bash
cd backend
cp .env.example .env   # fill in API keys
docker compose up --build
```

## Tests

```bash
pytest
```

## API

- `POST /api/v1/locations/search` — `{query}` → geocode candidates for disambiguation.
- `POST /api/v1/locations/{location_id}` — `{candidate, settings}` → full `LocationResponse` (cache-first).
- `POST /api/v1/locations/{location_id}/refresh?item_id=...` — force refetch one item, or all items if `item_id` omitted.
- `GET /api/v1/llm/usage?device_id=...` — free-tier usage snapshot for Settings.
- `GET /api/v1/cache/stats` / `DELETE /api/v1/cache` — for the Privacy settings screen.

See `SDD.md` §4 for the full response schema and §5 for per-item cache TTLs.
