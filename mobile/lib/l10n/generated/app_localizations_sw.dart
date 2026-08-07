// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Tafuta mahali, jiji, au anwani';

  @override
  String get searchButton => 'Tafuta';

  @override
  String get searchRecent => 'Za hivi karibuni';

  @override
  String get searchTryDemo => 'Jaribu onyesho (Da Lat)';

  @override
  String get searchNoResults =>
      'Hakuna matokeo yaliyopatikana. Jaribu utafutaji tofauti.';

  @override
  String get searchError =>
      'Hitilafu imetokea. Angalia muunganisho wako au jaribu onyesho.';

  @override
  String get searchChooseMatch => 'Chagua mahali';

  @override
  String get graphBack => 'Rudi';

  @override
  String get graphSettings => 'Mipangilio';

  @override
  String get graphHistory => 'Historia';

  @override
  String get graphRefresh => 'Onyesha upya';

  @override
  String get graphRefreshAll => 'Onyesha upya vyote';

  @override
  String get graphLoading => 'Inakusanya taarifa…';

  @override
  String get graphError => 'Imeshindwa kupakia mahali hapa.';

  @override
  String get graphRetry => 'Jaribu tena';

  @override
  String get detailSourceLlm => 'Muhtasari wa AI';

  @override
  String get detailSourceApi => 'Data ya moja kwa moja';

  @override
  String get detailSourceStatic => 'Data ya marejeleo';

  @override
  String get detailSourceSearch => 'Matokeo ghafi ya utafutaji';

  @override
  String get detailSourceMissingKey => 'Inahitaji ufunguo wa API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Imesasishwa $date';
  }

  @override
  String get detailStale =>
      'Inaonyesha data ya zamani iliyohifadhiwa — kusasisha kumeshindwa';

  @override
  String get detailSources => 'Vyanzo';

  @override
  String get detailNoData => 'Bado hakuna taarifa zinazopatikana.';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get settingsLanguageUnits => 'Lugha na Vipimo';

  @override
  String get settingsLanguageUnitsDesc =>
      'Lugha ya programu, lugha ya maudhui, vipimo vya umbali/joto';

  @override
  String get settingsApiKeys => 'Funguo za API';

  @override
  String get settingsApiKeysDesc =>
      'Hali ya hewa na utafutaji — maeneo/uwekaji jiografia havihitaji ufunguo';

  @override
  String get settingsAiAssistant => 'Msaidizi wa AI';

  @override
  String get settingsAiAssistantDesc =>
      'Ufunguo wako wa API wa LLM, kiwango cha maelezo, vyanzo';

  @override
  String get settingsDataPrivacy => 'Data na Faragha';

  @override
  String get settingsDataPrivacyDesc =>
      'Hifadhi ya muda, historia, ruhusa ya eneo, mwendo, ukubwa wa fonti';

  @override
  String get languageSettingsTitle => 'Lugha na Vipimo';

  @override
  String get uiLanguage => 'Lugha ya programu';

  @override
  String get contentLanguage => 'Lugha ya maudhui';

  @override
  String get contentLanguageDesc =>
      'Lugha inayotumika kwa maudhui yaliyofupishwa na AI — inaweza kutofautiana na lugha ya programu';

  @override
  String get distanceUnit => 'Kipimo cha umbali';

  @override
  String get temperatureUnit => 'Kipimo cha joto';

  @override
  String get currencyFormat => 'Muundo wa sarafu';

  @override
  String get km => 'Kilomita';

  @override
  String get miles => 'Maili';

  @override
  String get celsius => 'Selsiasi (°C)';

  @override
  String get fahrenheit => 'Farenhaiti (°F)';

  @override
  String get systemDefault => 'Chaguo-msingi la mfumo';

  @override
  String get apiKeysTitle => 'Funguo za API';

  @override
  String get placesNoKeyNote =>
      'Utafutaji, maeneo ya karibu, na uwanja wa ndege wa karibu hutumia OpenStreetMap (Nominatim + Overpass) — bila malipo, hakuna ufunguo wa API unaohitajika.';

  @override
  String get weatherApiKeyLabel => 'Ufunguo wa API wa OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Unahitajika kwa hali ya hewa ya sasa.';

  @override
  String get searchApiKeyLabel =>
      'Ufunguo wa API wa utafutaji wa Tavily (si lazima)';

  @override
  String get searchApiKeyDesc =>
      'Huegemeza majibu yaliyofupishwa na AI kwenye matokeo halisi ya utafutaji. Bila hiyo, AI hujibu kwa maarifa ya jumla pekee.';

  @override
  String get llmSettingsTitle => 'Msaidizi wa AI';

  @override
  String get llmEnabled => 'Wezesha muhtasari wa AI';

  @override
  String get llmEnabledDesc =>
      'Ikizimwa, vipengele hivyo huachwa wazi badala ya kuita LLM';

  @override
  String get byokProviderLabel => 'Mtoa huduma';

  @override
  String get byokApiKey => 'Ufunguo wa API';

  @override
  String get byokApiKeyHint =>
      'Imehifadhiwa kwa usalama kwenye kifaa hiki pekee';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Kiwango cha maelezo';

  @override
  String get detailLevelShort => 'Fupi';

  @override
  String get detailLevelDetailed => 'Kwa kina';

  @override
  String get showSources => 'Onyesha vyanzo';

  @override
  String get showSourcesDesc =>
      'Onyesha viungo ambavyo muhtasari wa AI ulitegemea';

  @override
  String get llmDisclaimer =>
      'Maudhui yaliyoandikwa \"Muhtasari wa AI\" huenda yasiwe sahihi. Daima thibitisha taarifa za visa, afya, na usalama kutoka vyanzo rasmi.';

  @override
  String get privacySettingsTitle => 'Data na Faragha';

  @override
  String get cacheSize => 'Ukubwa wa hifadhi ya muda';

  @override
  String get clearCache => 'Futa hifadhi ya muda';

  @override
  String get clearCacheConfirm =>
      'Hii itaondoa data zote za maeneo zilizohifadhiwa. Endelea?';

  @override
  String get locationHistory => 'Historia ya maeneo';

  @override
  String get clearHistory => 'Futa historia';

  @override
  String get clearHistoryConfirm =>
      'Hii itaondoa historia yako ya utafutaji. Endelea?';

  @override
  String get gpsPermission => 'Tumia eneo langu';

  @override
  String get gpsPermissionDesc =>
      'Hutumika kupata maeneo ndani ya kilomita 15 kutoka kwako. Unaweza daima kutafuta mwenyewe badala yake.';

  @override
  String get reducedMotion => 'Punguza mwendo';

  @override
  String get reducedMotionDesc =>
      'Zima uhuishaji wa mazingira kwenye grafu ya nodi';

  @override
  String get fontSize => 'Ukubwa wa fonti';

  @override
  String get historyTitle => 'Historia';

  @override
  String get historyEmpty => 'Bado hakuna mahali palipotafutwa.';

  @override
  String get save => 'Hifadhi';

  @override
  String get cancel => 'Ghairi';

  @override
  String get delete => 'Futa';

  @override
  String get close => 'Funga';

  @override
  String get groupExplore => 'Chunguza';

  @override
  String get groupPractical => 'Vitendo';

  @override
  String get groupSafety => 'Usalama na Afya';

  @override
  String get groupCulture => 'Utamaduni';

  @override
  String get groupEntryStay => 'Kuingia na Kukaa';
}
