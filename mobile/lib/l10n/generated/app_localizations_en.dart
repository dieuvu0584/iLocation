// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Search a place, city, or address';

  @override
  String get searchButton => 'Search';

  @override
  String get searchRecent => 'Recent';

  @override
  String get searchTryDemo => 'Try a demo (Da Lat)';

  @override
  String get searchNoResults => 'No matches found. Try a different search.';

  @override
  String get searchError =>
      'Something went wrong. Check your connection or try the demo.';

  @override
  String get searchChooseMatch => 'Choose a match';

  @override
  String get graphBack => 'Back';

  @override
  String get graphSettings => 'Settings';

  @override
  String get graphHistory => 'History';

  @override
  String get graphRefresh => 'Refresh';

  @override
  String get graphRefreshAll => 'Refresh all';

  @override
  String get graphLoading => 'Gathering information…';

  @override
  String get graphError => 'Couldn\'t load this location.';

  @override
  String get graphRetry => 'Retry';

  @override
  String get detailSourceLlm => 'AI-summarized';

  @override
  String get detailSourceApi => 'Live data';

  @override
  String get detailSourceStatic => 'Reference data';

  @override
  String get detailSourceSearch => 'Raw search results';

  @override
  String get detailSourceMissingKey => 'Needs API key';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Updated $date';
  }

  @override
  String get detailStale => 'Showing older cached data — refresh failed';

  @override
  String get detailSources => 'Sources';

  @override
  String get detailNoData => 'No information available yet.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguageUnits => 'Language & Units';

  @override
  String get settingsLanguageUnitsDesc =>
      'UI language, content language, distance/temperature units';

  @override
  String get settingsApiKeys => 'API Keys';

  @override
  String get settingsApiKeysDesc =>
      'Weather and search — places/geocoding needs no key';

  @override
  String get settingsAiAssistant => 'AI Assistant';

  @override
  String get settingsAiAssistantDesc =>
      'Your own LLM API key, detail level, sources';

  @override
  String get settingsDataPrivacy => 'Data & Privacy';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, history, location permission, motion, font size';

  @override
  String get languageSettingsTitle => 'Language & Units';

  @override
  String get uiLanguage => 'App language';

  @override
  String get contentLanguage => 'Content language';

  @override
  String get contentLanguageDesc =>
      'Language used for AI-summarized content — can differ from the app language';

  @override
  String get distanceUnit => 'Distance unit';

  @override
  String get temperatureUnit => 'Temperature unit';

  @override
  String get currencyFormat => 'Currency format';

  @override
  String get km => 'Kilometers';

  @override
  String get miles => 'Miles';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'System default';

  @override
  String get apiKeysTitle => 'API Keys';

  @override
  String get placesNoKeyNote =>
      'Search, nearby places, and the nearest airport run on OpenStreetMap (Nominatim + Overpass) — free, no API key needed.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API key';

  @override
  String get weatherApiKeyDesc => 'Needed for the current weather.';

  @override
  String get searchApiKeyLabel => 'Tavily search API key (optional)';

  @override
  String get searchApiKeyDesc =>
      'Grounds AI-summarized answers in real search results. Without it, the AI answers from general knowledge only.';

  @override
  String get llmSettingsTitle => 'AI Assistant';

  @override
  String get llmEnabled => 'Enable AI summaries';

  @override
  String get llmEnabledDesc =>
      'When off, those items are simply left blank instead of calling an LLM';

  @override
  String get byokProviderLabel => 'Provider';

  @override
  String get byokApiKey => 'API key';

  @override
  String get byokApiKeyHint => 'Stored securely on this device only';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Detail level';

  @override
  String get detailLevelShort => 'Short';

  @override
  String get detailLevelDetailed => 'Detailed';

  @override
  String get showSources => 'Show sources';

  @override
  String get showSourcesDesc => 'Display links AI summaries were based on';

  @override
  String get llmDisclaimer =>
      'Content marked \"AI-summarized\" may be inaccurate. Always verify visa, health, and safety information with official sources.';

  @override
  String get privacySettingsTitle => 'Data & Privacy';

  @override
  String get cacheSize => 'Cache size';

  @override
  String get clearCache => 'Clear cache';

  @override
  String get clearCacheConfirm =>
      'This will remove all cached location data. Continue?';

  @override
  String get locationHistory => 'Location history';

  @override
  String get clearHistory => 'Clear history';

  @override
  String get clearHistoryConfirm =>
      'This will remove your search history. Continue?';

  @override
  String get gpsPermission => 'Use my location';

  @override
  String get gpsPermissionDesc =>
      'Used to find places within 15km of you. You can always search manually instead.';

  @override
  String get reducedMotion => 'Reduce motion';

  @override
  String get reducedMotionDesc =>
      'Turn off ambient animation in the node graph';

  @override
  String get fontSize => 'Font size';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'No locations looked up yet.';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get groupExplore => 'Explore';

  @override
  String get groupPractical => 'Practical';

  @override
  String get groupSafety => 'Safety & Health';

  @override
  String get groupCulture => 'Culture';

  @override
  String get groupEntryStay => 'Entry & Stay';
}
