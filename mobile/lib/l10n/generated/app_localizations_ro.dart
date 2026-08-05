// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Caută un loc, oraș sau adresă';

  @override
  String get searchButton => 'Caută';

  @override
  String get searchRecent => 'Recente';

  @override
  String get searchTryDemo => 'Încearcă o demonstrație (Da Lat)';

  @override
  String get searchNoResults =>
      'Nu s-au găsit rezultate. Încearcă o altă căutare.';

  @override
  String get searchError =>
      'Ceva nu a mers bine. Verifică-ți conexiunea sau încearcă demonstrația.';

  @override
  String get searchChooseMatch => 'Alege un loc';

  @override
  String get graphBack => 'Înapoi';

  @override
  String get graphSettings => 'Setări';

  @override
  String get graphHistory => 'Istoric';

  @override
  String get graphRefresh => 'Reîmprospătează';

  @override
  String get graphRefreshAll => 'Reîmprospătează tot';

  @override
  String get graphLoading => 'Se colectează informații…';

  @override
  String get graphError => 'Acest loc nu a putut fi încărcat.';

  @override
  String get graphRetry => 'Reîncearcă';

  @override
  String get detailSourceLlm => 'Rezumat de AI';

  @override
  String get detailSourceApi => 'Date live';

  @override
  String get detailSourceStatic => 'Date de referință';

  @override
  String get detailSourceSearch => 'Rezultate brute de căutare';

  @override
  String get detailSourceMissingKey => 'Necesită cheie API';

  @override
  String detailUpdatedAt(String date) {
    return 'Actualizat $date';
  }

  @override
  String get detailStale =>
      'Se afișează date mai vechi din cache — reîmprospătarea a eșuat';

  @override
  String get detailSources => 'Surse';

  @override
  String get detailNoData => 'Nu există încă informații disponibile.';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get settingsLanguageUnits => 'Limbă și unități';

  @override
  String get settingsLanguageUnitsDesc =>
      'Limba aplicației, limba conținutului, unități de distanță/temperatură';

  @override
  String get settingsApiKeys => 'Chei API';

  @override
  String get settingsApiKeysDesc =>
      'Vreme și căutare — locurile/geocodarea nu necesită cheie';

  @override
  String get settingsAiAssistant => 'Asistent AI';

  @override
  String get settingsAiAssistantDesc =>
      'Propria cheie API LLM, nivel de detaliu, surse';

  @override
  String get settingsDataPrivacy => 'Date și confidențialitate';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, istoric, permisiune de locație, mișcare, dimensiunea fontului';

  @override
  String get languageSettingsTitle => 'Limbă și unități';

  @override
  String get uiLanguage => 'Limba aplicației';

  @override
  String get contentLanguage => 'Limba conținutului';

  @override
  String get contentLanguageDesc =>
      'Limba folosită pentru conținutul rezumat de AI — poate diferi de limba aplicației';

  @override
  String get distanceUnit => 'Unitate de distanță';

  @override
  String get temperatureUnit => 'Unitate de temperatură';

  @override
  String get currencyFormat => 'Format monedă';

  @override
  String get km => 'Kilometri';

  @override
  String get miles => 'Mile';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Implicit sistem';

  @override
  String get apiKeysTitle => 'Chei API';

  @override
  String get placesNoKeyNote =>
      'Căutarea, locurile din apropiere și cel mai apropiat aeroport funcționează pe OpenStreetMap (Nominatim + Overpass) — gratuit, fără a fi nevoie de cheie API.';

  @override
  String get weatherApiKeyLabel => 'Cheie API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Necesară pentru vremea curentă.';

  @override
  String get searchApiKeyLabel => 'Cheie API căutare Tavily (opțional)';

  @override
  String get searchApiKeyDesc =>
      'Bazează răspunsurile rezumate de AI pe rezultate reale de căutare. Fără aceasta, AI răspunde doar din cunoștințe generale.';

  @override
  String get llmSettingsTitle => 'Asistent AI';

  @override
  String get llmEnabled => 'Activează rezumatele AI';

  @override
  String get llmEnabledDesc =>
      'Când este dezactivat, aceste elemente rămân goale în loc să apeleze un LLM';

  @override
  String get byokProviderLabel => 'Furnizor';

  @override
  String get byokApiKey => 'Cheie API';

  @override
  String get byokApiKeyHint => 'Stocată în siguranță doar pe acest dispozitiv';

  @override
  String get detailLevel => 'Nivel de detaliu';

  @override
  String get detailLevelShort => 'Scurt';

  @override
  String get detailLevelDetailed => 'Detaliat';

  @override
  String get showSources => 'Afișează sursele';

  @override
  String get showSourcesDesc =>
      'Afișează linkurile pe care s-au bazat rezumatele AI';

  @override
  String get llmDisclaimer =>
      'Conținutul marcat \"Rezumat de AI\" poate fi inexact. Verifică întotdeauna informațiile despre viză, sănătate și siguranță din surse oficiale.';

  @override
  String get privacySettingsTitle => 'Date și confidențialitate';

  @override
  String get cacheSize => 'Dimensiune cache';

  @override
  String get clearCache => 'Golește cache-ul';

  @override
  String get clearCacheConfirm =>
      'Aceasta va elimina toate datele de locație stocate în cache. Continui?';

  @override
  String get locationHistory => 'Istoric locații';

  @override
  String get clearHistory => 'Șterge istoricul';

  @override
  String get clearHistoryConfirm =>
      'Aceasta va elimina istoricul tău de căutare. Continui?';

  @override
  String get gpsPermission => 'Folosește locația mea';

  @override
  String get gpsPermissionDesc =>
      'Folosit pentru a găsi locuri într-o rază de 15 km de tine. Poți oricând căuta manual în schimb.';

  @override
  String get reducedMotion => 'Redu mișcarea';

  @override
  String get reducedMotionDesc =>
      'Dezactivează animația ambientală din graful de noduri';

  @override
  String get fontSize => 'Dimensiunea fontului';

  @override
  String get historyTitle => 'Istoric';

  @override
  String get historyEmpty => 'Niciun loc căutat încă.';

  @override
  String get save => 'Salvează';

  @override
  String get cancel => 'Anulează';

  @override
  String get delete => 'Șterge';

  @override
  String get close => 'Închide';

  @override
  String get groupExplore => 'Explorează';

  @override
  String get groupPractical => 'Practic';

  @override
  String get groupSafety => 'Siguranță și sănătate';

  @override
  String get groupCulture => 'Cultură';

  @override
  String get groupEntryStay => 'Intrare și ședere';
}
