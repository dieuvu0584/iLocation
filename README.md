# Location Info Explorer

A mobile app for looking up a place anywhere in the world and getting
consolidated, useful information — presented as an interactive 2-tier
node-graph instead of a scrolling list. See `SDD.md` for the full design and
`CLAUDE.md` for project conventions and decisions.

- `backend/` — FastAPI service: cache-first pipeline over Google
  Places/Geocoding, a weather API, offline timezone lookup, a static
  emergency-numbers table, Tavily web search, and an LLM aggregator
  (Gemini Flash free tier, or bring-your-own-key).
- `mobile/` — Flutter app: the node-graph UI, settings (language/units, AI
  assistant, privacy), and simple search/history screens.

## Quick start

```bash
# Backend
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # fill in API keys as you get them
uvicorn app.main:app --reload

# Backend tests
pytest   # 26 tests, no API keys required

# Mobile (separate terminal)
cd mobile
flutter create .        # scaffolds android/ios/web/... — see mobile/README.md
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8000
```

Without any backend API keys configured, the app still runs — use the "Try
a demo" button on the search screen to explore the node-graph UI with fixture
data.

## Status

First full implementation pass — see `CLAUDE.md` → "Trạng thái hiện tại /
việc cần làm tiếp" for what's done and what's left (mainly: real API keys,
scaffolding Flutter platform folders, and testing on an actual
device/emulator, none of which were possible in the environment this was
built in).
