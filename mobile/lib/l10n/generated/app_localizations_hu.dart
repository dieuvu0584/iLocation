// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Keress helyet, várost vagy címet';

  @override
  String get searchButton => 'Keresés';

  @override
  String get searchRecent => 'Legutóbbiak';

  @override
  String get searchTryDemo => 'Próbáld ki a demót (Da Lat)';

  @override
  String get searchNoResults => 'Nincs találat. Próbálj más keresést.';

  @override
  String get searchError =>
      'Valami hiba történt. Ellenőrizd a kapcsolatot, vagy próbáld ki a demót.';

  @override
  String get searchChooseMatch => 'Válassz egy helyet';

  @override
  String get graphBack => 'Vissza';

  @override
  String get graphSettings => 'Beállítások';

  @override
  String get graphHistory => 'Előzmények';

  @override
  String get graphRefresh => 'Frissítés';

  @override
  String get graphRefreshAll => 'Összes frissítése';

  @override
  String get graphLoading => 'Információk gyűjtése…';

  @override
  String get graphError => 'Nem sikerült betölteni ezt a helyet.';

  @override
  String get graphRetry => 'Újra';

  @override
  String get detailSourceLlm => 'AI által összegzett';

  @override
  String get detailSourceApi => 'Élő adatok';

  @override
  String get detailSourceStatic => 'Referencia adatok';

  @override
  String get detailSourceSearch => 'Nyers keresési eredmények';

  @override
  String get detailSourceMissingKey => 'API kulcs szükséges';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Frissítve: $date';
  }

  @override
  String get detailStale =>
      'Régebbi gyorsítótárazott adatok jelennek meg — a frissítés sikertelen volt';

  @override
  String get detailSources => 'Források';

  @override
  String get detailNoData => 'Még nincs elérhető információ.';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get settingsLanguageUnits => 'Nyelv és mértékegységek';

  @override
  String get settingsLanguageUnitsDesc =>
      'Alkalmazás nyelve, tartalom nyelve, távolság/hőmérséklet mértékegységei';

  @override
  String get settingsApiKeys => 'API kulcsok';

  @override
  String get settingsApiKeysDesc =>
      'Időjárás és keresés — a helyekhez/geokódoláshoz nem szükséges kulcs';

  @override
  String get settingsAiAssistant => 'AI asszisztens';

  @override
  String get settingsAiAssistantDesc =>
      'Saját LLM API kulcsod, részletességi szint, források';

  @override
  String get settingsDataPrivacy => 'Adatok és adatvédelem';

  @override
  String get settingsDataPrivacyDesc =>
      'Gyorsítótár, előzmények, helyadat engedély, mozgás, betűméret';

  @override
  String get languageSettingsTitle => 'Nyelv és mértékegységek';

  @override
  String get uiLanguage => 'Alkalmazás nyelve';

  @override
  String get contentLanguage => 'Tartalom nyelve';

  @override
  String get contentLanguageDesc =>
      'Az AI által összegzett tartalomhoz használt nyelv — eltérhet az alkalmazás nyelvétől';

  @override
  String get distanceUnit => 'Távolság mértékegysége';

  @override
  String get temperatureUnit => 'Hőmérséklet mértékegysége';

  @override
  String get currencyFormat => 'Pénznem formátuma';

  @override
  String get km => 'Kilométer';

  @override
  String get miles => 'Mérföld';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Rendszer alapértelmezett';

  @override
  String get apiKeysTitle => 'API kulcsok';

  @override
  String get placesNoKeyNote =>
      'A keresés, a közeli helyek és a legközelebbi repülőtér az OpenStreetMap-en (Nominatim + Overpass) fut — ingyenes, API kulcs nem szükséges.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API kulcs';

  @override
  String get weatherApiKeyDesc => 'Szükséges az aktuális időjáráshoz.';

  @override
  String get searchApiKeyLabel => 'Tavily keresési API kulcs (opcionális)';

  @override
  String get searchApiKeyDesc =>
      'Valós keresési eredményekre alapozza az AI által összegzett válaszokat. Enélkül az AI csak általános tudásból válaszol.';

  @override
  String get llmSettingsTitle => 'AI asszisztens';

  @override
  String get llmEnabled => 'AI összegzések engedélyezése';

  @override
  String get llmEnabledDesc =>
      'Kikapcsolva ezek az elemek egyszerűen üresen maradnak ahelyett, hogy LLM-et hívnának';

  @override
  String get byokProviderLabel => 'Szolgáltató';

  @override
  String get byokApiKey => 'API kulcs';

  @override
  String get byokApiKeyHint => 'Biztonságosan, csak ezen az eszközön tárolva';

  @override
  String get detailLevel => 'Részletességi szint';

  @override
  String get detailLevelShort => 'Rövid';

  @override
  String get detailLevelDetailed => 'Részletes';

  @override
  String get showSources => 'Források megjelenítése';

  @override
  String get showSourcesDesc =>
      'Azon linkek megjelenítése, amelyeken az AI összegzések alapultak';

  @override
  String get llmDisclaimer =>
      'Az \"AI által összegzett\" jelölésű tartalom pontatlan lehet. A vízum-, egészségügyi és biztonsági információkat mindig hivatalos forrásból ellenőrizd.';

  @override
  String get privacySettingsTitle => 'Adatok és adatvédelem';

  @override
  String get cacheSize => 'Gyorsítótár mérete';

  @override
  String get clearCache => 'Gyorsítótár törlése';

  @override
  String get clearCacheConfirm =>
      'Ez eltávolítja az összes gyorsítótárazott helyadatot. Folytatod?';

  @override
  String get locationHistory => 'Helyelőzmények';

  @override
  String get clearHistory => 'Előzmények törlése';

  @override
  String get clearHistoryConfirm =>
      'Ez eltávolítja a keresési előzményeidet. Folytatod?';

  @override
  String get gpsPermission => 'Helyzetem használata';

  @override
  String get gpsPermissionDesc =>
      'A tőled 15 km-es körzetben lévő helyek megtalálására szolgál. Bármikor kereshetsz manuálisan is.';

  @override
  String get reducedMotion => 'Mozgás csökkentése';

  @override
  String get reducedMotionDesc =>
      'Környezeti animáció kikapcsolása a csomópontgráfban';

  @override
  String get fontSize => 'Betűméret';

  @override
  String get historyTitle => 'Előzmények';

  @override
  String get historyEmpty => 'Még nincs megtekintett hely.';

  @override
  String get save => 'Mentés';

  @override
  String get cancel => 'Mégse';

  @override
  String get delete => 'Törlés';

  @override
  String get close => 'Bezárás';

  @override
  String get groupExplore => 'Felfedezés';

  @override
  String get groupPractical => 'Gyakorlati';

  @override
  String get groupSafety => 'Biztonság és egészség';

  @override
  String get groupCulture => 'Kultúra';

  @override
  String get groupEntryStay => 'Belépés és tartózkodás';
}
