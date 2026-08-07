// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Søg efter et sted, en by eller adresse';

  @override
  String get searchButton => 'Søg';

  @override
  String get searchRecent => 'Seneste';

  @override
  String get searchTryDemo => 'Prøv en demo (Da Lat)';

  @override
  String get searchNoResults => 'Ingen match fundet. Prøv en anden søgning.';

  @override
  String get searchError =>
      'Noget gik galt. Tjek din forbindelse, eller prøv demoen.';

  @override
  String get searchChooseMatch => 'Vælg et sted';

  @override
  String get graphBack => 'Tilbage';

  @override
  String get graphSettings => 'Indstillinger';

  @override
  String get graphHistory => 'Historik';

  @override
  String get graphRefresh => 'Opdater';

  @override
  String get graphRefreshAll => 'Opdater alt';

  @override
  String get graphLoading => 'Indsamler information…';

  @override
  String get graphError => 'Kunne ikke indlæse dette sted.';

  @override
  String get graphRetry => 'Prøv igen';

  @override
  String get detailSourceLlm => 'Opsummeret af AI';

  @override
  String get detailSourceApi => 'Livedata';

  @override
  String get detailSourceStatic => 'Referencedata';

  @override
  String get detailSourceSearch => 'Rå søgeresultater';

  @override
  String get detailSourceMissingKey => 'Kræver API-nøgle';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Opdateret $date';
  }

  @override
  String get detailStale => 'Viser ældre cachede data — opdatering mislykkedes';

  @override
  String get detailSources => 'Kilder';

  @override
  String get detailNoData => 'Ingen oplysninger tilgængelige endnu.';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get settingsLanguageUnits => 'Sprog og enheder';

  @override
  String get settingsLanguageUnitsDesc =>
      'App-sprog, indholdssprog, afstands-/temperaturenheder';

  @override
  String get settingsApiKeys => 'API-nøgler';

  @override
  String get settingsApiKeysDesc =>
      'Vejr og søgning — steder/geokodning kræver ingen nøgle';

  @override
  String get settingsAiAssistant => 'AI-assistent';

  @override
  String get settingsAiAssistantDesc =>
      'Din egen LLM API-nøgle, detaljeniveau, kilder';

  @override
  String get settingsDataPrivacy => 'Data og privatliv';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, historik, placeringstilladelse, bevægelse, skriftstørrelse';

  @override
  String get languageSettingsTitle => 'Sprog og enheder';

  @override
  String get uiLanguage => 'App-sprog';

  @override
  String get contentLanguage => 'Indholdssprog';

  @override
  String get contentLanguageDesc =>
      'Sprog brugt til AI-opsummeret indhold — kan afvige fra app-sproget';

  @override
  String get distanceUnit => 'Afstandsenhed';

  @override
  String get temperatureUnit => 'Temperaturenhed';

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
  String get apiKeysTitle => 'API-nøgler';

  @override
  String get placesNoKeyNote =>
      'Søgning, steder i nærheden og nærmeste lufthavn kører på OpenStreetMap (Nominatim + Overpass) — gratis, ingen API-nøgle nødvendig.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API-nøgle';

  @override
  String get weatherApiKeyDesc => 'Nødvendig for aktuelt vejr.';

  @override
  String get searchApiKeyLabel => 'Tavily søge-API-nøgle (valgfrit)';

  @override
  String get searchApiKeyDesc =>
      'Baserer AI-opsummerede svar på virkelige søgeresultater. Uden den svarer AI\'en kun ud fra generel viden.';

  @override
  String get llmSettingsTitle => 'AI-assistent';

  @override
  String get llmEnabled => 'Aktivér AI-resuméer';

  @override
  String get llmEnabledDesc =>
      'Når slået fra, forbliver disse elementer blot tomme i stedet for at kalde en LLM';

  @override
  String get byokProviderLabel => 'Udbyder';

  @override
  String get byokApiKey => 'API-nøgle';

  @override
  String get byokApiKeyHint => 'Gemmes sikkert kun på denne enhed';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Detaljeniveau';

  @override
  String get detailLevelShort => 'Kort';

  @override
  String get detailLevelDetailed => 'Detaljeret';

  @override
  String get showSources => 'Vis kilder';

  @override
  String get showSourcesDesc => 'Vis links, som AI-resuméer var baseret på';

  @override
  String get llmDisclaimer =>
      'Indhold mærket \"Opsummeret af AI\" kan være unøjagtigt. Bekræft altid visum-, sundheds- og sikkerhedsoplysninger med officielle kilder.';

  @override
  String get privacySettingsTitle => 'Data og privatliv';

  @override
  String get cacheSize => 'Cachestørrelse';

  @override
  String get clearCache => 'Ryd cache';

  @override
  String get clearCacheConfirm =>
      'Dette fjerner alle cachede stedsdata. Fortsæt?';

  @override
  String get locationHistory => 'Stedshistorik';

  @override
  String get clearHistory => 'Ryd historik';

  @override
  String get clearHistoryConfirm => 'Dette fjerner din søgehistorik. Fortsæt?';

  @override
  String get gpsPermission => 'Brug min placering';

  @override
  String get gpsPermissionDesc =>
      'Bruges til at finde steder inden for 15 km fra dig. Du kan altid søge manuelt i stedet.';

  @override
  String get reducedMotion => 'Reducer bevægelse';

  @override
  String get reducedMotionDesc => 'Slå baggrundsanimation fra i knudegrafen';

  @override
  String get fontSize => 'Skriftstørrelse';

  @override
  String get historyTitle => 'Historik';

  @override
  String get historyEmpty => 'Ingen steder opslået endnu.';

  @override
  String get save => 'Gem';

  @override
  String get cancel => 'Annuller';

  @override
  String get delete => 'Slet';

  @override
  String get close => 'Luk';

  @override
  String get groupExplore => 'Udforsk';

  @override
  String get groupPractical => 'Praktisk';

  @override
  String get groupSafety => 'Sikkerhed og sundhed';

  @override
  String get groupCulture => 'Kultur';

  @override
  String get groupEntryStay => 'Indrejse og ophold';
}
