// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Maghanap ng lugar, lungsod, o address';

  @override
  String get searchButton => 'Maghanap';

  @override
  String get searchRecent => 'Kamakailan';

  @override
  String get searchTryDemo => 'Subukan ang demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Walang nahanap na tugma. Subukan ang ibang paghahanap.';

  @override
  String get searchError =>
      'May naganap na problema. Suriin ang iyong koneksyon o subukan ang demo.';

  @override
  String get searchChooseMatch => 'Pumili ng lugar';

  @override
  String get graphBack => 'Bumalik';

  @override
  String get graphSettings => 'Mga Setting';

  @override
  String get graphHistory => 'Kasaysayan';

  @override
  String get graphRefresh => 'I-refresh';

  @override
  String get graphRefreshAll => 'I-refresh lahat';

  @override
  String get graphLoading => 'Kinukolekta ang impormasyon…';

  @override
  String get graphError => 'Hindi ma-load ang lugar na ito.';

  @override
  String get graphRetry => 'Subukan ulit';

  @override
  String get detailSourceLlm => 'Ibinuod ng AI';

  @override
  String get detailSourceApi => 'Live na data';

  @override
  String get detailSourceStatic => 'Data ng sanggunian';

  @override
  String get detailSourceSearch => 'Hilaw na resulta ng paghahanap';

  @override
  String get detailSourceMissingKey => 'Kailangan ng API key';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Na-update noong $date';
  }

  @override
  String get detailStale =>
      'Ipinapakita ang mas lumang naka-cache na data — nabigo ang pag-refresh';

  @override
  String get detailSources => 'Mga Pinagmulan';

  @override
  String get detailNoData => 'Wala pang impormasyong available.';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get settingsLanguageUnits => 'Wika at Mga Yunit';

  @override
  String get settingsLanguageUnitsDesc =>
      'Wika ng app, wika ng nilalaman, mga yunit ng distansya/temperatura';

  @override
  String get settingsApiKeys => 'Mga API Key';

  @override
  String get settingsApiKeysDesc =>
      'Panahon at paghahanap — hindi nangangailangan ng key ang mga lugar/geocoding';

  @override
  String get settingsAiAssistant => 'AI Assistant';

  @override
  String get settingsAiAssistantDesc =>
      'Sarili mong LLM API key, antas ng detalye, mga pinagmulan';

  @override
  String get settingsDataPrivacy => 'Data at Privacy';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, kasaysayan, pahintulot sa lokasyon, galaw, laki ng font';

  @override
  String get languageSettingsTitle => 'Wika at Mga Yunit';

  @override
  String get uiLanguage => 'Wika ng app';

  @override
  String get contentLanguage => 'Wika ng nilalaman';

  @override
  String get contentLanguageDesc =>
      'Wikang ginagamit para sa nilalamang ibinuod ng AI — maaaring iba sa wika ng app';

  @override
  String get distanceUnit => 'Yunit ng distansya';

  @override
  String get temperatureUnit => 'Yunit ng temperatura';

  @override
  String get currencyFormat => 'Format ng currency';

  @override
  String get km => 'Kilometro';

  @override
  String get miles => 'Milya';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Default ng system';

  @override
  String get apiKeysTitle => 'Mga API Key';

  @override
  String get placesNoKeyNote =>
      'Ang paghahanap, malapit na lugar, at pinakamalapit na paliparan ay gumagamit ng OpenStreetMap (Nominatim + Overpass) — libre, walang kailangang API key.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API key';

  @override
  String get weatherApiKeyDesc => 'Kailangan para sa kasalukuyang panahon.';

  @override
  String get searchApiKeyLabel => 'Tavily search API key (opsyonal)';

  @override
  String get searchApiKeyDesc =>
      'Ibinabatay ang mga sagot na ibinuod ng AI sa aktwal na resulta ng paghahanap. Kung wala nito, sasagot lamang ang AI batay sa pangkalahatang kaalaman.';

  @override
  String get llmSettingsTitle => 'AI Assistant';

  @override
  String get llmEnabled => 'I-enable ang mga buod ng AI';

  @override
  String get llmEnabledDesc =>
      'Kapag naka-off, iiwang blangko na lang ang mga item na iyon sa halip na tumawag sa isang LLM';

  @override
  String get byokProviderLabel => 'Provider';

  @override
  String get byokApiKey => 'API key';

  @override
  String get byokApiKeyHint => 'Ligtas na naka-imbak lamang sa device na ito';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Antas ng detalye';

  @override
  String get detailLevelShort => 'Maikli';

  @override
  String get detailLevelDetailed => 'Detalyado';

  @override
  String get showSources => 'Ipakita ang mga pinagmulan';

  @override
  String get showSourcesDesc =>
      'Ipakita ang mga link na pinagbatayan ng mga buod ng AI';

  @override
  String get llmDisclaimer =>
      'Ang nilalamang minarkahan bilang \"Ibinuod ng AI\" ay maaaring hindi tumpak. Laging i-verify ang impormasyon sa visa, kalusugan, at kaligtasan gamit ang mga opisyal na pinagmulan.';

  @override
  String get privacySettingsTitle => 'Data at Privacy';

  @override
  String get cacheSize => 'Laki ng cache';

  @override
  String get clearCache => 'I-clear ang cache';

  @override
  String get clearCacheConfirm =>
      'Aalisin nito ang lahat ng naka-cache na data ng lokasyon. Magpatuloy?';

  @override
  String get locationHistory => 'Kasaysayan ng lokasyon';

  @override
  String get clearHistory => 'I-clear ang kasaysayan';

  @override
  String get clearHistoryConfirm =>
      'Aalisin nito ang iyong kasaysayan ng paghahanap. Magpatuloy?';

  @override
  String get gpsPermission => 'Gamitin ang aking lokasyon';

  @override
  String get gpsPermissionDesc =>
      'Ginagamit upang mahanap ang mga lugar sa loob ng 15km mula sa iyo. Maaari ka pa ring maghanap nang manwal sa halip.';

  @override
  String get reducedMotion => 'Bawasan ang galaw';

  @override
  String get reducedMotionDesc => 'I-off ang ambient animation sa node graph';

  @override
  String get fontSize => 'Laki ng font';

  @override
  String get historyTitle => 'Kasaysayan';

  @override
  String get historyEmpty => 'Wala pang na-search na lokasyon.';

  @override
  String get save => 'I-save';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get delete => 'Tanggalin';

  @override
  String get close => 'Isara';

  @override
  String get groupExplore => 'Galugarin';

  @override
  String get groupPractical => 'Praktikal';

  @override
  String get groupSafety => 'Kaligtasan at Kalusugan';

  @override
  String get groupCulture => 'Kultura';

  @override
  String get groupEntryStay => 'Pagpasok at Pananatili';
}
