import 'package:flutter/material.dart';

import '../models/settings_models.dart';
import '../services/secure_storage.dart';
import '../services/settings_service.dart';

/// Reactive wrapper around SettingsService + SecureStorageService so widgets
/// can listen for changes (locale, units, LLM config, reduced motion, etc).
class AppSettings extends ChangeNotifier {
  final SettingsService _settings;
  final SecureStorageService _secureStorage;

  AppSettings(this._settings, this._secureStorage);

  static Future<AppSettings> create() async {
    final settings = await SettingsService.create();
    return AppSettings(settings, SecureStorageService());
  }

  String get deviceId => _settings.deviceId;

  Locale? get uiLocale {
    final code = _settings.uiLocale;
    return code == null ? null : Locale(code);
  }

  Future<void> setUiLocale(Locale? locale) async {
    await _settings.setUiLocale(locale?.languageCode);
    notifyListeners();
  }

  String get contentLanguage => _settings.contentLanguage;
  Future<void> setContentLanguage(String code) async {
    await _settings.setContentLanguage(code);
    notifyListeners();
  }

  DistanceUnit get distanceUnit => _settings.distanceUnit;
  Future<void> setDistanceUnit(DistanceUnit unit) async {
    await _settings.setDistanceUnit(unit);
    notifyListeners();
  }

  TemperatureUnit get temperatureUnit => _settings.temperatureUnit;
  Future<void> setTemperatureUnit(TemperatureUnit unit) async {
    await _settings.setTemperatureUnit(unit);
    notifyListeners();
  }

  String get currencyFormat => _settings.currencyFormat;
  Future<void> setCurrencyFormat(String value) async {
    await _settings.setCurrencyFormat(value);
    notifyListeners();
  }

  bool get llmEnabled => _settings.llmEnabled;
  Future<void> setLlmEnabled(bool value) async {
    await _settings.setLlmEnabled(value);
    notifyListeners();
  }

  ProviderMode get providerMode => _settings.providerMode;
  Future<void> setProviderMode(ProviderMode mode) async {
    await _settings.setProviderMode(mode);
    notifyListeners();
  }

  ByokProvider get byokProvider => _settings.byokProvider;
  Future<void> setByokProvider(ByokProvider provider) async {
    await _settings.setByokProvider(provider);
    notifyListeners();
  }

  Future<String?> getByokApiKey() => _secureStorage.readByokApiKey();

  Future<void> setByokApiKey(String apiKey) async {
    await _secureStorage.writeByokApiKey(apiKey);
    notifyListeners();
  }

  Future<void> clearByokApiKey() async {
    await _secureStorage.deleteByokApiKey();
    notifyListeners();
  }

  bool get fallbackEnabled => _settings.fallbackEnabled;
  Future<void> setFallbackEnabled(bool value) async {
    await _settings.setFallbackEnabled(value);
    notifyListeners();
  }

  DetailLevel get detailLevel => _settings.detailLevel;
  Future<void> setDetailLevel(DetailLevel level) async {
    await _settings.setDetailLevel(level);
    notifyListeners();
  }

  bool get showSources => _settings.showSources;
  Future<void> setShowSources(bool value) async {
    await _settings.setShowSources(value);
    notifyListeners();
  }

  bool get gpsEnabled => _settings.gpsEnabled;
  Future<void> setGpsEnabled(bool value) async {
    await _settings.setGpsEnabled(value);
    notifyListeners();
  }

  bool get reducedMotion => _settings.reducedMotion;
  Future<void> setReducedMotion(bool value) async {
    await _settings.setReducedMotion(value);
    notifyListeners();
  }

  double get fontScale => _settings.fontScale;
  Future<void> setFontScale(double value) async {
    await _settings.setFontScale(value);
    notifyListeners();
  }

  /// Builds the per-request settings payload sent to the backend with every
  /// location fetch (SDD §7.2). Reads the BYOK key from secure storage only
  /// at call time — it is never cached in memory beyond this object.
  Future<LlmRequestSettings> buildLlmRequestSettings() async {
    final byok = providerMode == ProviderMode.byok;
    return LlmRequestSettings(
      deviceId: deviceId,
      llmEnabled: llmEnabled,
      providerMode: providerMode,
      byokProvider: byok ? byokProvider : null,
      byokApiKey: byok ? await getByokApiKey() : null,
      fallbackEnabled: fallbackEnabled,
      detailLevel: detailLevel,
      showSources: showSources,
      contentLanguage: contentLanguage,
    );
  }
}
