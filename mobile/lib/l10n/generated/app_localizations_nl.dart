// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Zoek een plaats, stad of adres';

  @override
  String get searchButton => 'Zoeken';

  @override
  String get searchRecent => 'Recent';

  @override
  String get searchTryDemo => 'Probeer een demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Geen resultaten gevonden. Probeer een andere zoekopdracht.';

  @override
  String get searchError =>
      'Er is iets misgegaan. Controleer je verbinding of probeer de demo.';

  @override
  String get searchChooseMatch => 'Kies een plaats';

  @override
  String get graphBack => 'Terug';

  @override
  String get graphSettings => 'Instellingen';

  @override
  String get graphHistory => 'Geschiedenis';

  @override
  String get graphRefresh => 'Vernieuwen';

  @override
  String get graphRefreshAll => 'Alles vernieuwen';

  @override
  String get graphLoading => 'Informatie verzamelen…';

  @override
  String get graphError => 'Deze locatie kon niet worden geladen.';

  @override
  String get graphRetry => 'Opnieuw proberen';

  @override
  String get detailSourceLlm => 'Samengevat door AI';

  @override
  String get detailSourceApi => 'Live data';

  @override
  String get detailSourceStatic => 'Referentiegegevens';

  @override
  String get detailSourceSearch => 'Ruwe zoekresultaten';

  @override
  String get detailSourceMissingKey => 'API-sleutel vereist';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Bijgewerkt $date';
  }

  @override
  String get detailStale =>
      'Oudere gecachte gegevens worden getoond — vernieuwen mislukt';

  @override
  String get detailSources => 'Bronnen';

  @override
  String get detailNoData => 'Nog geen informatie beschikbaar.';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsLanguageUnits => 'Taal en eenheden';

  @override
  String get settingsLanguageUnitsDesc =>
      'App-taal, inhoudstaal, afstands-/temperatuureenheden';

  @override
  String get settingsApiKeys => 'API-sleutels';

  @override
  String get settingsApiKeysDesc =>
      'Weer en zoeken — locaties/geocodering hebben geen sleutel nodig';

  @override
  String get settingsAiAssistant => 'AI-assistent';

  @override
  String get settingsAiAssistantDesc =>
      'Je eigen LLM-API-sleutel, detailniveau, bronnen';

  @override
  String get settingsDataPrivacy => 'Gegevens en privacy';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, geschiedenis, locatietoestemming, beweging, tekstgrootte';

  @override
  String get languageSettingsTitle => 'Taal en eenheden';

  @override
  String get uiLanguage => 'App-taal';

  @override
  String get contentLanguage => 'Inhoudstaal';

  @override
  String get contentLanguageDesc =>
      'Taal gebruikt voor door AI samengevatte inhoud — kan afwijken van de app-taal';

  @override
  String get distanceUnit => 'Afstandseenheid';

  @override
  String get temperatureUnit => 'Temperatuureenheid';

  @override
  String get currencyFormat => 'Valutaformaat';

  @override
  String get km => 'Kilometers';

  @override
  String get miles => 'Mijlen';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Systeemstandaard';

  @override
  String get apiKeysTitle => 'API-sleutels';

  @override
  String get placesNoKeyNote =>
      'Zoeken, locaties in de buurt en de dichtstbijzijnde luchthaven werken via OpenStreetMap (Nominatim + Overpass) — gratis, geen API-sleutel nodig.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API-sleutel';

  @override
  String get weatherApiKeyDesc => 'Nodig voor het huidige weer.';

  @override
  String get searchApiKeyLabel => 'Tavily zoek-API-sleutel (optioneel)';

  @override
  String get searchApiKeyDesc =>
      'Onderbouwt door AI samengevatte antwoorden met echte zoekresultaten. Zonder deze antwoordt de AI alleen op basis van algemene kennis.';

  @override
  String get llmSettingsTitle => 'AI-assistent';

  @override
  String get llmEnabled => 'AI-samenvattingen inschakelen';

  @override
  String get llmEnabledDesc =>
      'Indien uitgeschakeld, blijven die items gewoon leeg in plaats van een LLM aan te roepen';

  @override
  String get byokProviderLabel => 'Aanbieder';

  @override
  String get byokApiKey => 'API-sleutel';

  @override
  String get byokApiKeyHint => 'Alleen veilig opgeslagen op dit apparaat';

  @override
  String get detailLevel => 'Detailniveau';

  @override
  String get detailLevelShort => 'Kort';

  @override
  String get detailLevelDetailed => 'Gedetailleerd';

  @override
  String get showSources => 'Bronnen tonen';

  @override
  String get showSourcesDesc =>
      'Toon links waarop AI-samenvattingen zijn gebaseerd';

  @override
  String get llmDisclaimer =>
      'Inhoud gemarkeerd als \"Samengevat door AI\" kan onnauwkeurig zijn. Controleer visum-, gezondheids- en veiligheidsinformatie altijd bij officiële bronnen.';

  @override
  String get privacySettingsTitle => 'Gegevens en privacy';

  @override
  String get cacheSize => 'Cachegrootte';

  @override
  String get clearCache => 'Cache wissen';

  @override
  String get clearCacheConfirm =>
      'Hiermee worden alle gecachte locatiegegevens verwijderd. Doorgaan?';

  @override
  String get locationHistory => 'Locatiegeschiedenis';

  @override
  String get clearHistory => 'Geschiedenis wissen';

  @override
  String get clearHistoryConfirm =>
      'Hiermee wordt je zoekgeschiedenis verwijderd. Doorgaan?';

  @override
  String get gpsPermission => 'Mijn locatie gebruiken';

  @override
  String get gpsPermissionDesc =>
      'Wordt gebruikt om plaatsen binnen 15 km van jou te vinden. Je kunt altijd handmatig zoeken in plaats daarvan.';

  @override
  String get reducedMotion => 'Beweging beperken';

  @override
  String get reducedMotionDesc =>
      'Zet omgevingsanimatie in de knopengrafiek uit';

  @override
  String get fontSize => 'Tekstgrootte';

  @override
  String get historyTitle => 'Geschiedenis';

  @override
  String get historyEmpty => 'Nog geen locaties opgezocht.';

  @override
  String get save => 'Opslaan';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get close => 'Sluiten';

  @override
  String get groupExplore => 'Verkennen';

  @override
  String get groupPractical => 'Praktisch';

  @override
  String get groupSafety => 'Veiligheid en gezondheid';

  @override
  String get groupCulture => 'Cultuur';

  @override
  String get groupEntryStay => 'Inreizen en verblijf';
}
