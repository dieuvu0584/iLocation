# Location Info Explorer — Backend

> **Not used by the mobile app.** The app was rearchitected to be fully
> client-side (SQLite cache on-device, direct BYOK calls to every provider)
> — see `CLAUDE.md` → "Quyết định đã chốt 2026-08-04 (đợt 2)". This service
> still runs and has its own test suite, kept here in case a server-side
> cache is wanted again later, but nothing in `mobile/` calls it anymore.

FastAPI backend implementing the pipeline described in `SDD.md` §3: cache-first,
then parallel Places/Weather/timezone/emergency-table lookups plus web-search +
LLM summarization for the remaining free-text fields.

## Run locally

```bash
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # fill in API keys
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

Without any API keys configured, the server still starts; endpoints that need
a given provider return `502` for that call. Fill in `.env` incrementally as
you get keys for Google Places/Geocoding, OpenWeatherMap, Tavily, and Gemini.

`--host 0.0.0.0` matters if you're testing the mobile app on a **real
device**: it's what makes the server reachable from your phone over the same
WiFi network at `http://<your-computer's-LAN-IP>:8000`. `--host 127.0.0.1`
(uvicorn's default) is only reachable from the same machine — fine for an
Android emulator (via its `10.0.2.2` alias) or a desktop build, but a phone
can't reach it at all. Find your LAN IP with `ipconfig getifaddr en0` (macOS)
or `hostname -I` (Linux), then enter `http://<that-ip>:8000` in the app's
Data & Privacy settings → "Backend server URL".

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
