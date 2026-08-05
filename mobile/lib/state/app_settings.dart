import 'package:flutter/material.dart';

import '../l10n/locale_codes.dart';
import '../models/settings_models.dart';
import '../services/secure_storage.dart';
import '../services/settings_service.dart';

/// Reactive wrapper around SettingsService + SecureStorageService so widgets
/// can listen for changes (locale, units, LLM config, reduced motion, etc).
/// Client-only architecture (CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt
/// 2)") — every provider key is BYOK, there's no free-tier/device_id/backend
/// concept anymore.
class AppSettings extends ChangeNotifier {
  final SettingsService _settings;
  final SecureStorageService _secureStorage;

  AppSettings(this._settings, this._secureStorage);

  static Future<AppSettings> create() async {
    final settings = await SettingsService.create();
    return AppSettings(settings, SecureStorageService());
  }

  Locale? get uiLocale {
    final code = _settings.uiLocale;
    return code == null ? null : localeFromCode(code);
  }

  Future<void> setUiLocale(Locale? locale) async {
    await _settings.setUiLocale(locale == null ? null : localeToCode(locale));
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

  ByokProvider get llmProvider => _settings.byokProvider;
  Future<void> setLlmProvider(ByokProvider provider) async {
    await _settings.setByokProvider(provider);
    notifyListeners();
  }

  Future<String?> getLlmApiKey() => _secureStorage.readLlmApiKey();
  Future<void> setLlmApiKey(String apiKey) async {
    await _secureStorage.writeLlmApiKey(apiKey);
    notifyListeners();
  }

  Future<String?> getWeatherApiKey() => _secureStorage.readWeatherApiKey();
  Future<void> setWeatherApiKey(String apiKey) async {
    await _secureStorage.writeWeatherApiKey(apiKey);
    notifyListeners();
  }

  Future<String?> getSearchApiKey() => _secureStorage.readSearchApiKey();
  Future<void> setSearchApiKey(String apiKey) async {
    await _secureStorage.writeSearchApiKey(apiKey);
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

  /// Builds the settings payload the orchestrator needs to resolve one
  /// location. Reads every key from secure storage only at call time — none
  /// of them are cached in memory beyond this object, and none ever leave
  /// the device except in a request to the provider that owns that key.
  Future<RequestSettings> buildRequestSettings() async {
    return RequestSettings(
      llmEnabled: llmEnabled,
      llmProvider: llmProvider,
      llmApiKey: await getLlmApiKey(),
      detailLevel: detailLevel,
      showSources: showSources,
      contentLanguage: contentLanguage,
      weatherApiKey: await getWeatherApiKey(),
      searchApiKey: await getSearchApiKey(),
    );
  }
}
