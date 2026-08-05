// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Søk etter et sted, by eller adresse';

  @override
  String get searchButton => 'Søk';

  @override
  String get searchRecent => 'Nylige';

  @override
  String get searchTryDemo => 'Prøv en demo (Da Lat)';

  @override
  String get searchNoResults => 'Ingen treff funnet. Prøv et annet søk.';

  @override
  String get searchError =>
      'Noe gikk galt. Sjekk tilkoblingen din eller prøv demoen.';

  @override
  String get searchChooseMatch => 'Velg et sted';

  @override
  String get graphBack => 'Tilbake';

  @override
  String get graphSettings => 'Innstillinger';

  @override
  String get graphHistory => 'Historikk';

  @override
  String get graphRefresh => 'Oppdater';

  @override
  String get graphRefreshAll => 'Oppdater alt';

  @override
  String get graphLoading => 'Samler informasjon…';

  @override
  String get graphError => 'Kunne ikke laste dette stedet.';

  @override
  String get graphRetry => 'Prøv igjen';

  @override
  String get detailSourceLlm => 'Oppsummert av AI';

  @override
  String get detailSourceApi => 'Sanntidsdata';

  @override
  String get detailSourceStatic => 'Referansedata';

  @override
  String get detailSourceSearch => 'Rå søkeresultater';

  @override
  String get detailSourceMissingKey => 'Krever API-nøkkel';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Oppdatert $date';
  }

  @override
  String get detailStale => 'Viser eldre bufrede data — oppdatering mislyktes';

  @override
  String get detailSources => 'Kilder';

  @override
  String get detailNoData => 'Ingen informasjon tilgjengelig ennå.';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get settingsLanguageUnits => 'Språk og enheter';

  @override
  String get settingsLanguageUnitsDesc =>
      'Appspråk, innholdsspråk, avstands-/temperaturenheter';

  @override
  String get settingsApiKeys => 'API-nøkler';

  @override
  String get settingsApiKeysDesc =>
      'Vær og søk — steder/geokoding trenger ingen nøkkel';

  @override
  String get settingsAiAssistant => 'AI-assistent';

  @override
  String get settingsAiAssistantDesc =>
      'Din egen LLM API-nøkkel, detaljnivå, kilder';

  @override
  String get settingsDataPrivacy => 'Data og personvern';

  @override
  String get settingsDataPrivacyDesc =>
      'Buffer, historikk, posisjonstillatelse, bevegelse, skriftstørrelse';

  @override
  String get languageSettingsTitle => 'Språk og enheter';

  @override
  String get uiLanguage => 'Appspråk';

  @override
  String get contentLanguage => 'Innholdsspråk';

  @override
  String get contentLanguageDesc =>
      'Språk brukt for AI-oppsummert innhold — kan avvike fra appspråket';

  @override
  String get distanceUnit => 'Avstandsenhet';

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
  String get apiKeysTitle => 'API-nøkler';

  @override
  String get placesNoKeyNote =>
      'Søk, steder i nærheten og nærmeste flyplass kjører på OpenStreetMap (Nominatim + Overpass) — gratis, ingen API-nøkkel nødvendig.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API-nøkkel';

  @override
  String get weatherApiKeyDesc => 'Nødvendig for gjeldende vær.';

  @override
  String get searchApiKeyLabel => 'Tavily søke-API-nøkkel (valgfritt)';

  @override
  String get searchApiKeyDesc =>
      'Baserer AI-oppsummerte svar på ekte søkeresultater. Uten den svarer AI-en kun ut fra generell kunnskap.';

  @override
  String get llmSettingsTitle => 'AI-assistent';

  @override
  String get llmEnabled => 'Aktiver AI-sammendrag';

  @override
  String get llmEnabledDesc =>
      'Når av, forblir disse elementene bare tomme i stedet for å kalle en LLM';

  @override
  String get byokProviderLabel => 'Leverandør';

  @override
  String get byokApiKey => 'API-nøkkel';

  @override
  String get byokApiKeyHint => 'Lagres sikkert kun på denne enheten';

  @override
  String get detailLevel => 'Detaljnivå';

  @override
  String get detailLevelShort => 'Kort';

  @override
  String get detailLevelDetailed => 'Detaljert';

  @override
  String get showSources => 'Vis kilder';

  @override
  String get showSourcesDesc => 'Vis lenker AI-sammendrag var basert på';

  @override
  String get llmDisclaimer =>
      'Innhold merket «Oppsummert av AI» kan være unøyaktig. Bekreft alltid visum-, helse- og sikkerhetsinformasjon med offisielle kilder.';

  @override
  String get privacySettingsTitle => 'Data og personvern';

  @override
  String get cacheSize => 'Bufferstørrelse';

  @override
  String get clearCache => 'Tøm buffer';

  @override
  String get clearCacheConfirm =>
      'Dette fjerner alle bufrede stedsdata. Fortsette?';

  @override
  String get locationHistory => 'Stedshistorikk';

  @override
  String get clearHistory => 'Tøm historikk';

  @override
  String get clearHistoryConfirm =>
      'Dette fjerner søkehistorikken din. Fortsette?';

  @override
  String get gpsPermission => 'Bruk min posisjon';

  @override
  String get gpsPermissionDesc =>
      'Brukes til å finne steder innen 15 km fra deg. Du kan alltid søke manuelt i stedet.';

  @override
  String get reducedMotion => 'Reduser bevegelse';

  @override
  String get reducedMotionDesc => 'Slå av bakgrunnsanimasjon i nodegrafen';

  @override
  String get fontSize => 'Skriftstørrelse';

  @override
  String get historyTitle => 'Historikk';

  @override
  String get historyEmpty => 'Ingen steder slått opp ennå.';

  @override
  String get save => 'Lagre';

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Slett';

  @override
  String get close => 'Lukk';

  @override
  String get groupExplore => 'Utforsk';

  @override
  String get groupPractical => 'Praktisk';

  @override
  String get groupSafety => 'Sikkerhet og helse';

  @override
  String get groupCulture => 'Kultur';

  @override
  String get groupEntryStay => 'Innreise og opphold';
}
