/// Settings shape for the client-only architecture (CLAUDE.md "Quyết định
/// đã chốt 2026-08-04 (đợt 2)"). Every provider is BYOK — there is no
/// free-tier/fallback/device_id concept anymore, since there's no backend
/// to hold a shared key or enforce a shared rate limit.
library;

enum ByokProvider { gemini, groq, openrouter, openai }

enum DetailLevel { short, detailed }

enum DistanceUnit { km, miles }

enum TemperatureUnit { celsius, fahrenheit }

extension ByokProviderX on ByokProvider {
  String get apiValue => name;

  static ByokProvider fromApiValue(String value) =>
      ByokProvider.values.firstWhere((e) => e.apiValue == value, orElse: () => ByokProvider.gemini);
}

extension DetailLevelX on DetailLevel {
  String get apiValue => this == DetailLevel.short ? 'short' : 'detailed';
}

/// Everything needed to resolve one location's data, read fresh from
/// AppSettings/SecureStorageService right before use — keys are never
/// cached in memory beyond the single orchestrator run that needs them.
///
/// No `placesApiKey`: Places/Geocoding runs on OpenStreetMap
/// (Nominatim + Overpass), which needs no key at all (CLAUDE.md "Quyết
/// định đã chốt 2026-08-04 (đợt 3)").
class RequestSettings {
  final bool llmEnabled;
  final ByokProvider llmProvider;
  final String? llmApiKey;
  final DetailLevel detailLevel;
  final bool showSources;
  final String contentLanguage;
  final String? weatherApiKey;
  final String? searchApiKey;

  const RequestSettings({
    required this.llmEnabled,
    required this.llmProvider,
    this.llmApiKey,
    required this.detailLevel,
    required this.showSources,
    required this.contentLanguage,
    this.weatherApiKey,
    this.searchApiKey,
  });

  bool get hasLlmKey => llmApiKey != null && llmApiKey!.trim().isNotEmpty;
  bool get hasWeatherKey => weatherApiKey != null && weatherApiKey!.trim().isNotEmpty;
  bool get hasSearchKey => searchApiKey != null && searchApiKey!.trim().isNotEmpty;
}
