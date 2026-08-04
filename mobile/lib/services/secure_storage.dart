import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Used ONLY for API keys (CLAUDE.md: "MỌI API key BYOK... không dùng cho
/// gì khác"). Now covers every provider the app calls directly — LLM,
/// Places/Geocoding, Weather, Search — since there's no backend to hold
/// any of them (CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt 2)").
/// Everything else (non-secret settings) lives in SettingsService.
class SecureStorageService {
  static const _llmApiKeyStorageKey = 'llm_api_key';
  static const _placesApiKeyStorageKey = 'places_api_key';
  static const _weatherApiKeyStorageKey = 'weather_api_key';
  static const _searchApiKeyStorageKey = 'search_api_key';

  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> readLlmApiKey() => _storage.read(key: _llmApiKeyStorageKey);
  Future<void> writeLlmApiKey(String apiKey) => _storage.write(key: _llmApiKeyStorageKey, value: apiKey);
  Future<void> deleteLlmApiKey() => _storage.delete(key: _llmApiKeyStorageKey);

  Future<String?> readPlacesApiKey() => _storage.read(key: _placesApiKeyStorageKey);
  Future<void> writePlacesApiKey(String apiKey) => _storage.write(key: _placesApiKeyStorageKey, value: apiKey);
  Future<void> deletePlacesApiKey() => _storage.delete(key: _placesApiKeyStorageKey);

  Future<String?> readWeatherApiKey() => _storage.read(key: _weatherApiKeyStorageKey);
  Future<void> writeWeatherApiKey(String apiKey) => _storage.write(key: _weatherApiKeyStorageKey, value: apiKey);
  Future<void> deleteWeatherApiKey() => _storage.delete(key: _weatherApiKeyStorageKey);

  Future<String?> readSearchApiKey() => _storage.read(key: _searchApiKeyStorageKey);
  Future<void> writeSearchApiKey(String apiKey) => _storage.write(key: _searchApiKeyStorageKey, value: apiKey);
  Future<void> deleteSearchApiKey() => _storage.delete(key: _searchApiKeyStorageKey);
}
