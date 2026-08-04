import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings_models.dart';

/// Wraps SharedPreferences for every setting that isn't secret (SDD §7).
/// API keys are the exception — see SecureStorageService. Client-only
/// architecture (CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt 2)"): no
/// device_id/rate-limit/backend-URL concept anymore.
class SettingsService {
  static const _kUiLocale = 'ui_locale'; // null/absent = follow system
  static const _kContentLanguage = 'content_language';
  static const _kDistanceUnit = 'distance_unit';
  static const _kTemperatureUnit = 'temperature_unit';
  static const _kCurrencyFormat = 'currency_format';
  static const _kLlmEnabled = 'llm_enabled';
  static const _kByokProvider = 'byok_provider';
  static const _kDetailLevel = 'detail_level';
  static const _kShowSources = 'show_sources';
  static const _kGpsEnabled = 'gps_enabled';
  static const _kReducedMotion = 'reduced_motion';
  static const _kFontScale = 'font_scale';

  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  static Future<SettingsService> create() async => SettingsService(await SharedPreferences.getInstance());

  String? get uiLocale => _prefs.getString(_kUiLocale);
  Future<void> setUiLocale(String? localeCode) async {
    if (localeCode == null) {
      await _prefs.remove(_kUiLocale);
    } else {
      await _prefs.setString(_kUiLocale, localeCode);
    }
  }

  /// Content language defaults to the UI language but can be overridden
  /// independently (SDD §7.1 — these are two separate settings).
  String get contentLanguage => _prefs.getString(_kContentLanguage) ?? uiLocale ?? 'en';
  Future<void> setContentLanguage(String code) => _prefs.setString(_kContentLanguage, code);

  DistanceUnit get distanceUnit =>
      _prefs.getString(_kDistanceUnit) == 'miles' ? DistanceUnit.miles : DistanceUnit.km;
  Future<void> setDistanceUnit(DistanceUnit unit) =>
      _prefs.setString(_kDistanceUnit, unit == DistanceUnit.miles ? 'miles' : 'km');

  TemperatureUnit get temperatureUnit =>
      _prefs.getString(_kTemperatureUnit) == 'fahrenheit' ? TemperatureUnit.fahrenheit : TemperatureUnit.celsius;
  Future<void> setTemperatureUnit(TemperatureUnit unit) =>
      _prefs.setString(_kTemperatureUnit, unit == TemperatureUnit.fahrenheit ? 'fahrenheit' : 'celsius');

  String get currencyFormat => _prefs.getString(_kCurrencyFormat) ?? 'USD';
  Future<void> setCurrencyFormat(String value) => _prefs.setString(_kCurrencyFormat, value);

  bool get llmEnabled => _prefs.getBool(_kLlmEnabled) ?? true;
  Future<void> setLlmEnabled(bool value) => _prefs.setBool(_kLlmEnabled, value);

  ByokProvider get byokProvider => ByokProviderX.fromApiValue(_prefs.getString(_kByokProvider) ?? 'gemini');
  Future<void> setByokProvider(ByokProvider provider) => _prefs.setString(_kByokProvider, provider.apiValue);

  DetailLevel get detailLevel =>
      _prefs.getString(_kDetailLevel) == 'detailed' ? DetailLevel.detailed : DetailLevel.short;
  Future<void> setDetailLevel(DetailLevel level) =>
      _prefs.setString(_kDetailLevel, level == DetailLevel.detailed ? 'detailed' : 'short');

  bool get showSources => _prefs.getBool(_kShowSources) ?? true;
  Future<void> setShowSources(bool value) => _prefs.setBool(_kShowSources, value);

  bool get gpsEnabled => _prefs.getBool(_kGpsEnabled) ?? false;
  Future<void> setGpsEnabled(bool value) => _prefs.setBool(_kGpsEnabled, value);

  bool get reducedMotion => _prefs.getBool(_kReducedMotion) ?? false;
  Future<void> setReducedMotion(bool value) => _prefs.setBool(_kReducedMotion, value);

  double get fontScale => _prefs.getDouble(_kFontScale) ?? 1.0;
  Future<void> setFontScale(double value) => _prefs.setDouble(_kFontScale, value);
}
