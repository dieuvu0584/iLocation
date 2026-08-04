import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/settings_models.dart';

/// Wraps SharedPreferences for every setting that isn't secret (SDD §7).
/// The BYOK API key is the one exception — see SecureStorageService.
class SettingsService {
  static const _kDeviceId = 'device_id';
  static const _kUiLocale = 'ui_locale'; // null/absent = follow system
  static const _kContentLanguage = 'content_language';
  static const _kDistanceUnit = 'distance_unit';
  static const _kTemperatureUnit = 'temperature_unit';
  static const _kCurrencyFormat = 'currency_format';
  static const _kLlmEnabled = 'llm_enabled';
  static const _kProviderMode = 'provider_mode';
  static const _kByokProvider = 'byok_provider';
  static const _kFallbackEnabled = 'fallback_enabled';
  static const _kDetailLevel = 'detail_level';
  static const _kShowSources = 'show_sources';
  static const _kGpsEnabled = 'gps_enabled';
  static const _kReducedMotion = 'reduced_motion';
  static const _kFontScale = 'font_scale';

  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  static Future<SettingsService> create() async => SettingsService(await SharedPreferences.getInstance());

  /// Stable per-install identifier used for free-tier rate limiting
  /// (CLAUDE.md principle #4) — not a user account, just a device tag.
  String get deviceId {
    var id = _prefs.getString(_kDeviceId);
    if (id == null) {
      id = const Uuid().v4();
      _prefs.setString(_kDeviceId, id);
    }
    return id;
  }

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

  ProviderMode get providerMode =>
      _prefs.getString(_kProviderMode) == 'byok' ? ProviderMode.byok : ProviderMode.free;
  Future<void> setProviderMode(ProviderMode mode) =>
      _prefs.setString(_kProviderMode, mode == ProviderMode.byok ? 'byok' : 'free');

  ByokProvider get byokProvider => ByokProviderX.fromApiValue(_prefs.getString(_kByokProvider) ?? 'gemini');
  Future<void> setByokProvider(ByokProvider provider) => _prefs.setString(_kByokProvider, provider.apiValue);

  bool get fallbackEnabled => _prefs.getBool(_kFallbackEnabled) ?? false;
  Future<void> setFallbackEnabled(bool value) => _prefs.setBool(_kFallbackEnabled, value);

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
