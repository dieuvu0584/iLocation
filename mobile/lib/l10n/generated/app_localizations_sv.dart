// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Sök efter en plats, stad eller adress';

  @override
  String get searchButton => 'Sök';

  @override
  String get searchRecent => 'Senaste';

  @override
  String get searchTryDemo => 'Prova en demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Inga matchningar hittades. Prova en annan sökning.';

  @override
  String get searchError =>
      'Något gick fel. Kontrollera din anslutning eller prova demon.';

  @override
  String get searchChooseMatch => 'Välj en plats';

  @override
  String get graphBack => 'Tillbaka';

  @override
  String get graphSettings => 'Inställningar';

  @override
  String get graphHistory => 'Historik';

  @override
  String get graphRefresh => 'Uppdatera';

  @override
  String get graphRefreshAll => 'Uppdatera allt';

  @override
  String get graphLoading => 'Samlar information…';

  @override
  String get graphError => 'Kunde inte läsa in den här platsen.';

  @override
  String get graphRetry => 'Försök igen';

  @override
  String get detailSourceLlm => 'Sammanfattat av AI';

  @override
  String get detailSourceApi => 'Livedata';

  @override
  String get detailSourceStatic => 'Referensdata';

  @override
  String get detailSourceSearch => 'Obehandlade sökresultat';

  @override
  String get detailSourceMissingKey => 'Kräver API-nyckel';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Uppdaterad $date';
  }

  @override
  String get detailStale =>
      'Visar äldre cachad data — uppdateringen misslyckades';

  @override
  String get detailSources => 'Källor';

  @override
  String get detailNoData => 'Ingen information tillgänglig ännu.';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get settingsLanguageUnits => 'Språk och enheter';

  @override
  String get settingsLanguageUnitsDesc =>
      'Appspråk, innehållsspråk, avstånds-/temperaturenheter';

  @override
  String get settingsApiKeys => 'API-nycklar';

  @override
  String get settingsApiKeysDesc =>
      'Väder och sökning — platser/geokodning kräver ingen nyckel';

  @override
  String get settingsAiAssistant => 'AI-assistent';

  @override
  String get settingsAiAssistantDesc =>
      'Din egen LLM-API-nyckel, detaljnivå, källor';

  @override
  String get settingsDataPrivacy => 'Data och integritet';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, historik, platsbehörighet, rörelse, teckenstorlek';

  @override
  String get languageSettingsTitle => 'Språk och enheter';

  @override
  String get uiLanguage => 'Appspråk';

  @override
  String get contentLanguage => 'Innehållsspråk';

  @override
  String get contentLanguageDesc =>
      'Språk som används för AI-sammanfattat innehåll — kan skilja sig från appspråket';

  @override
  String get distanceUnit => 'Avståndsenhet';

  @override
  String get temperatureUnit => 'Temperaturenhet';

  @override
  String get currencyFormat => 'Valutaformat';

  @override
  String get km => 'Kilometer';

  @override
  String get miles => 'Miles';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get apiKeysTitle => 'API-nycklar';

  @override
  String get placesNoKeyNote =>
      'Sökning, platser i närheten och närmaste flygplats körs på OpenStreetMap (Nominatim + Overpass) — gratis, ingen API-nyckel behövs.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API-nyckel';

  @override
  String get weatherApiKeyDesc => 'Krävs för aktuellt väder.';

  @override
  String get searchApiKeyLabel => 'Tavily sök-API-nyckel (valfritt)';

  @override
  String get searchApiKeyDesc =>
      'Grundar AI-sammanfattade svar i verkliga sökresultat. Utan den svarar AI:n endast utifrån allmän kunskap.';

  @override
  String get llmSettingsTitle => 'AI-assistent';

  @override
  String get llmEnabled => 'Aktivera AI-sammanfattningar';

  @override
  String get llmEnabledDesc =>
      'När avstängt lämnas dessa poster helt enkelt tomma istället för att anropa en LLM';

  @override
  String get byokProviderLabel => 'Leverantör';

  @override
  String get byokApiKey => 'API-nyckel';

  @override
  String get byokApiKeyHint => 'Lagras säkert endast på den här enheten';

  @override
  String get detailLevel => 'Detaljnivå';

  @override
  String get detailLevelShort => 'Kort';

  @override
  String get detailLevelDetailed => 'Detaljerad';

  @override
  String get showSources => 'Visa källor';

  @override
  String get showSourcesDesc =>
      'Visa länkar som AI-sammanfattningar baserades på';

  @override
  String get llmDisclaimer =>
      'Innehåll märkt \"Sammanfattat av AI\" kan vara felaktigt. Kontrollera alltid visum-, hälso- och säkerhetsinformation med officiella källor.';

  @override
  String get privacySettingsTitle => 'Data och integritet';

  @override
  String get cacheSize => 'Cachestorlek';

  @override
  String get clearCache => 'Rensa cache';

  @override
  String get clearCacheConfirm =>
      'Detta tar bort all cachad platsdata. Fortsätta?';

  @override
  String get locationHistory => 'Platshistorik';

  @override
  String get clearHistory => 'Rensa historik';

  @override
  String get clearHistoryConfirm =>
      'Detta tar bort din sökhistorik. Fortsätta?';

  @override
  String get gpsPermission => 'Använd min position';

  @override
  String get gpsPermissionDesc =>
      'Används för att hitta platser inom 15 km från dig. Du kan alltid söka manuellt istället.';

  @override
  String get reducedMotion => 'Minska rörelse';

  @override
  String get reducedMotionDesc => 'Stäng av bakgrundsanimation i nodgrafen';

  @override
  String get fontSize => 'Teckenstorlek';

  @override
  String get historyTitle => 'Historik';

  @override
  String get historyEmpty => 'Inga platser uppslagna ännu.';

  @override
  String get save => 'Spara';

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Ta bort';

  @override
  String get close => 'Stäng';

  @override
  String get groupExplore => 'Utforska';

  @override
  String get groupPractical => 'Praktiskt';

  @override
  String get groupSafety => 'Säkerhet och hälsa';

  @override
  String get groupCulture => 'Kultur';

  @override
  String get groupEntryStay => 'Inresa och vistelse';
}
