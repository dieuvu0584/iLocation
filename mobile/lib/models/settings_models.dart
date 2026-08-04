/// Mirrors backend/app/models/settings.py (SDD §7.2).
library;

enum ProviderMode { free, byok }

enum ByokProvider { gemini, groq, openrouter, openai }

enum DetailLevel { short, detailed }

enum DistanceUnit { km, miles }

enum TemperatureUnit { celsius, fahrenheit }

extension ProviderModeX on ProviderMode {
  String get apiValue => this == ProviderMode.free ? 'free' : 'byok';
}

extension ByokProviderX on ByokProvider {
  String get apiValue => name;

  static ByokProvider fromApiValue(String value) =>
      ByokProvider.values.firstWhere((e) => e.apiValue == value, orElse: () => ByokProvider.gemini);
}

extension DetailLevelX on DetailLevel {
  String get apiValue => this == DetailLevel.short ? 'short' : 'detailed';
}

/// Request payload sent alongside every location fetch — the BYOK API key
/// (if any) lives here only for the duration of one request; it is read from
/// secure storage right before the call and never persisted by this object.
class LlmRequestSettings {
  final String deviceId;
  final bool llmEnabled;
  final ProviderMode providerMode;
  final ByokProvider? byokProvider;
  final String? byokApiKey;
  final bool fallbackEnabled;
  final DetailLevel detailLevel;
  final bool showSources;
  final String contentLanguage;

  const LlmRequestSettings({
    required this.deviceId,
    required this.llmEnabled,
    required this.providerMode,
    this.byokProvider,
    this.byokApiKey,
    required this.fallbackEnabled,
    required this.detailLevel,
    required this.showSources,
    required this.contentLanguage,
  });

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'llm_enabled': llmEnabled,
        'provider_mode': providerMode.apiValue,
        'byok_provider': byokProvider?.apiValue,
        'byok_api_key': byokApiKey,
        'fallback_enabled': fallbackEnabled,
        'detail_level': detailLevel.apiValue,
        'show_sources': showSources,
        'content_language': contentLanguage,
      };
}
