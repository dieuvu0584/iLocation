// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Hledejte místo, město nebo adresu';

  @override
  String get searchButton => 'Hledat';

  @override
  String get searchRecent => 'Nedávné';

  @override
  String get searchTryDemo => 'Vyzkoušet demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Nebyly nalezeny žádné shody. Zkuste jiné hledání.';

  @override
  String get searchError =>
      'Něco se pokazilo. Zkontrolujte připojení nebo vyzkoušejte demo.';

  @override
  String get searchChooseMatch => 'Vyberte místo';

  @override
  String get graphBack => 'Zpět';

  @override
  String get graphSettings => 'Nastavení';

  @override
  String get graphHistory => 'Historie';

  @override
  String get graphRefresh => 'Obnovit';

  @override
  String get graphRefreshAll => 'Obnovit vše';

  @override
  String get graphLoading => 'Shromažďování informací…';

  @override
  String get graphError => 'Toto místo se nepodařilo načíst.';

  @override
  String get graphRetry => 'Zkusit znovu';

  @override
  String get detailSourceLlm => 'Shrnuto AI';

  @override
  String get detailSourceApi => 'Živá data';

  @override
  String get detailSourceStatic => 'Referenční data';

  @override
  String get detailSourceSearch => 'Nezpracované výsledky hledání';

  @override
  String get detailSourceMissingKey => 'Vyžaduje API klíč';

  @override
  String detailUpdatedAt(String date) {
    return 'Aktualizováno $date';
  }

  @override
  String get detailStale =>
      'Zobrazují se starší data z mezipaměti — obnovení se nezdařilo';

  @override
  String get detailSources => 'Zdroje';

  @override
  String get detailNoData => 'Zatím nejsou k dispozici žádné informace.';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get settingsLanguageUnits => 'Jazyk a jednotky';

  @override
  String get settingsLanguageUnitsDesc =>
      'Jazyk aplikace, jazyk obsahu, jednotky vzdálenosti/teploty';

  @override
  String get settingsApiKeys => 'API klíče';

  @override
  String get settingsApiKeysDesc =>
      'Počasí a hledání — místa/geokódování nevyžadují klíč';

  @override
  String get settingsAiAssistant => 'AI asistent';

  @override
  String get settingsAiAssistantDesc =>
      'Váš vlastní API klíč LLM, úroveň podrobnosti, zdroje';

  @override
  String get settingsDataPrivacy => 'Data a soukromí';

  @override
  String get settingsDataPrivacyDesc =>
      'Mezipaměť, historie, oprávnění k poloze, pohyb, velikost písma';

  @override
  String get languageSettingsTitle => 'Jazyk a jednotky';

  @override
  String get uiLanguage => 'Jazyk aplikace';

  @override
  String get contentLanguage => 'Jazyk obsahu';

  @override
  String get contentLanguageDesc =>
      'Jazyk používaný pro obsah shrnutý AI — může se lišit od jazyka aplikace';

  @override
  String get distanceUnit => 'Jednotka vzdálenosti';

  @override
  String get temperatureUnit => 'Jednotka teploty';

  @override
  String get currencyFormat => 'Formát měny';

  @override
  String get km => 'Kilometry';

  @override
  String get miles => 'Míle';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Výchozí nastavení systému';

  @override
  String get apiKeysTitle => 'API klíče';

  @override
  String get placesNoKeyNote =>
      'Hledání, blízká místa a nejbližší letiště běží na OpenStreetMap (Nominatim + Overpass) — zdarma, bez nutnosti API klíče.';

  @override
  String get weatherApiKeyLabel => 'API klíč OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Vyžadováno pro aktuální počasí.';

  @override
  String get searchApiKeyLabel => 'API klíč vyhledávání Tavily (volitelné)';

  @override
  String get searchApiKeyDesc =>
      'Zakládá odpovědi shrnuté AI na skutečných výsledcích vyhledávání. Bez něj AI odpovídá pouze na základě obecných znalostí.';

  @override
  String get llmSettingsTitle => 'AI asistent';

  @override
  String get llmEnabled => 'Povolit shrnutí AI';

  @override
  String get llmEnabledDesc =>
      'Když je vypnuto, tyto položky zůstanou prázdné místo volání LLM';

  @override
  String get byokProviderLabel => 'Poskytovatel';

  @override
  String get byokApiKey => 'API klíč';

  @override
  String get byokApiKeyHint => 'Bezpečně uloženo pouze na tomto zařízení';

  @override
  String get detailLevel => 'Úroveň podrobnosti';

  @override
  String get detailLevelShort => 'Stručné';

  @override
  String get detailLevelDetailed => 'Podrobné';

  @override
  String get showSources => 'Zobrazit zdroje';

  @override
  String get showSourcesDesc =>
      'Zobrazit odkazy, na kterých byla shrnutí AI založena';

  @override
  String get llmDisclaimer =>
      'Obsah označený jako \"Shrnuto AI\" nemusí být přesný. Informace o vízech, zdraví a bezpečnosti vždy ověřte u oficiálních zdrojů.';

  @override
  String get privacySettingsTitle => 'Data a soukromí';

  @override
  String get cacheSize => 'Velikost mezipaměti';

  @override
  String get clearCache => 'Vymazat mezipaměť';

  @override
  String get clearCacheConfirm =>
      'Tím se odstraní všechna data o místech uložená v mezipaměti. Pokračovat?';

  @override
  String get locationHistory => 'Historie míst';

  @override
  String get clearHistory => 'Vymazat historii';

  @override
  String get clearHistoryConfirm =>
      'Tím se odstraní vaše historie hledání. Pokračovat?';

  @override
  String get gpsPermission => 'Použít moji polohu';

  @override
  String get gpsPermissionDesc =>
      'Používá se k nalezení míst do 15 km od vás. Vždy můžete místo toho hledat ručně.';

  @override
  String get reducedMotion => 'Omezit pohyb';

  @override
  String get reducedMotionDesc => 'Vypnout ambientní animaci v grafu uzlů';

  @override
  String get fontSize => 'Velikost písma';

  @override
  String get historyTitle => 'Historie';

  @override
  String get historyEmpty => 'Zatím nebyla vyhledána žádná místa.';

  @override
  String get save => 'Uložit';

  @override
  String get cancel => 'Zrušit';

  @override
  String get delete => 'Odstranit';

  @override
  String get close => 'Zavřít';

  @override
  String get groupExplore => 'Prozkoumat';

  @override
  String get groupPractical => 'Praktické';

  @override
  String get groupSafety => 'Bezpečnost a zdraví';

  @override
  String get groupCulture => 'Kultura';

  @override
  String get groupEntryStay => 'Vstup a pobyt';
}
