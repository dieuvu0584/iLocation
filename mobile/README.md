# Location Info Explorer — Mobile

Flutter app implementing the node-graph UI from `SDD.md` §6. **Fully
client-side** — no backend server (see `CLAUDE.md` → "Quyết định đã chốt
2026-08-04 (đợt 2)"). The app calls OpenStreetMap (Places/Geocoding, no key
needed), OpenWeatherMap, Tavily, and your chosen LLM provider directly,
using API keys you enter in Settings, and caches results in a local SQLite
database on the device.

The `../backend` FastAPI service still exists in this repo (it has its own
tests and works standalone) but the app does **not** call it anymore.

## Getting real data: add your API keys

Search, nearby places, and the nearest airport already work with **no setup**
— they run on OpenStreetMap (Nominatim + Overpass API), which is free and
needs no key (swapped from Google Places/Geocoding on 2026-08-04, see
`CLAUDE.md` "đợt 3" — the tradeoff is a shared public instance that can be
slower than Google under load, in exchange for never needing a credit card).

For the rest, open **Settings → API Keys** and enter:

- **OpenWeatherMap API key** — powers the current weather.
- **Tavily search API key** (optional) — grounds AI-summarized answers in
  real search results. Without it, the LLM answers from general knowledge
  only and says so.

Then in **Settings → AI Assistant**, pick an LLM provider (Gemini / Groq /
OpenRouter / OpenAI) and enter that provider's API key — needed for the 16
free-text items (food, safety, culture, visa, etc. — see SDD §4). All keys
are written to `flutter_secure_storage` and are only ever sent to the
provider that issued them.

No keys configured? Tap **"Try a demo (Da Lat)"** on the search screen —
it loads fixture data from `lib/data/mock_location.dart`, fully offline, no
keys needed.

## Verified build

Flutter 3.44.8 (stable) was installed in the build environment and used to
verify this app for real, including after the client-only rewrite:

- `flutter pub get`, `flutter analyze` (0 issues), and `flutter test` all
  ran clean.
- `flutter build linux` compiled successfully, and the built binary was
  actually launched (under Xvfb): search (with and without an API key
  configured), the demo node-graph (tier 1 → tier 2 → detail panel with a
  working refresh button), the new API Keys screen, the simplified AI
  Assistant screen, and Data & Privacy (reading real stats from the local
  SQLite cache) all rendered and worked correctly.
- That same run caught a real bug — a `flutter_secure_storage` read left
  outside a `try/catch` in the search flow could hang the UI forever on any
  read failure, not just the desktop-only "keyring unavailable" error that
  surfaced it here. Fixed before shipping.
- `sqflite` only ships native implementations for Android/iOS — desktop dev
  builds (Linux/Windows) fall back to `sqflite_common_ffi`, wired up in
  `main.dart`. The shipped Android app always uses real `sqflite`.

What's still unverified: an actual Android build with real API keys
end-to-end (this build environment has no Android SDK — see
`.github/workflows/build-apk.yml`, which builds the release APK on GitHub
Actions instead), and iOS (no Xcode here either). A live search against
Nominatim couldn't be tested from this sandbox either — its own network
policy blocks `nominatim.openstreetmap.org` and `overpass-api.de` the same
way it blocks `dl.google.com` (see backend build notes) — but that's a
restriction on this dev container's outbound traffic only, unrelated to a
phone's normal network. The error-handling path was still exercised end to
end: the blocked request surfaced as a clean, catchable error with a demo
fallback, not a hang.

## Setup

```bash
cd mobile
flutter create .          # scaffolds android/ios/web/etc. around lib/
flutter pub get
flutter run
```

## Structure

- `lib/screens/graph/` — the node-graph (tier 1 groups, tier 2 details, detail panel).
- `lib/screens/settings/` — language/units, API keys, AI assistant (LLM), data & privacy.
- `lib/screens/search/`, `lib/screens/history/` — simple functional screens; SDD §10 had no spec for these, so they're deliberately minimal.
- `lib/widgets/node_graph/` — ring layout math, node widgets, connector painter, all animation respecting reduced-motion.
- `lib/theme/` — palette + typography locked in by SDD §9 / CLAUDE.md, do not change without checking with the project owner.
- `lib/db/`, `lib/services/cache_service.dart` — local SQLite cache (Dart port of the original backend's cache layer), per-item TTL.
- `lib/services/{geocode,places}_service.dart` — OpenStreetMap (Nominatim + Overpass), no key. `lib/services/{weather,web_search,llm}_service.dart` — direct-from-client BYOK calls. All are ports of the original backend services.
- `lib/services/orchestrator_service.dart` — ties the above together: cache-first, then fetch whatever's missing (Dart port of the original backend orchestrator).
- `lib/services/secure_storage.dart` — remaining API keys (LLM, Weather, Search); `settings_service.dart` / `history_service.dart` — everything else (SharedPreferences).
- `lib/state/` — `AppSettings` and `LocationProvider`, both `ChangeNotifier`s wired via `provider`.

## Icon set note

The SDD prototype used `lucide_icons`/`flutter_lucide`. This environment
can't verify exact package versions against pub.dev, so Material Icons are
used instead via a single mapping table (`lib/widgets/node_graph/graph_icons.dart`)
— swap the package in there if you want the closer visual match.
