/// Compile-time default API keys, baked in only via `--dart-define` at CI
/// build time from GitHub Actions secrets (see `.github/workflows/build-apk.yml`)
/// — never committed to the repo. Empty string when not supplied (local dev
/// builds, PRs, etc), which `AppSettings._orNonEmpty` treats as "no default".
class BuildTimeDefaults {
  BuildTimeDefaults._();

  static const weatherApiKey = String.fromEnvironment('DEFAULT_WEATHER_API_KEY');
  static const tavilyApiKey = String.fromEnvironment('DEFAULT_TAVILY_API_KEY');
  static const groqApiKey = String.fromEnvironment('DEFAULT_GROQ_API_KEY');
}
