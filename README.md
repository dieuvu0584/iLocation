# Location Info Explorer

A mobile app for looking up a place anywhere in the world and getting
consolidated, useful information — presented as an interactive 2-tier
node-graph instead of a scrolling list. See `SDD.md` for the full design and
`CLAUDE.md` for project conventions and decisions.

**Architecture: fully client-side.** The Flutter app calls Google
Places/Geocoding, OpenWeatherMap, Tavily, and your chosen LLM provider
directly, using API keys you enter in the app's Settings, and caches
results in a local SQLite database on the device. There is no backend
server in the running app.

- `mobile/` — the entire app: node-graph UI, on-device cache + provider
  calls (BYOK), settings (language/units, API keys, AI assistant, privacy),
  and simple search/history screens.
- `backend/` — an earlier FastAPI implementation of the same pipeline
  (cache-first, Places/Weather/timezone/emergency lookups, Tavily search, an
  LLM aggregator). It still runs and has its own test suite, but the mobile
  app doesn't call it — kept in the repo in case a server-side cache is
  wanted again later. See `CLAUDE.md` for why this changed.

## Quick start

```bash
cd mobile
flutter create .        # scaffolds android/ios/web/... — see mobile/README.md
flutter pub get
flutter run
```

Then in the app, open **Settings → API Keys** and **Settings → AI
Assistant** to enter your provider keys (see `mobile/README.md` for exactly
which ones and what they unlock). No keys yet? Tap **"Try a demo (Da Lat)"**
on the search screen — works fully offline with fixture data.

To build an installable APK, see `.github/workflows/build-apk.yml` (builds
on GitHub Actions, since Android builds need an Android SDK this dev
environment doesn't have) or run `flutter build apk` yourself with the
Android SDK installed.

## Status

See `CLAUDE.md` → "Trạng thái hiện tại / việc cần làm tiếp" for what's done
and what's left — mainly: testing with real API keys on a real device (this
build environment has none configured), and an iOS build (no Xcode here).
