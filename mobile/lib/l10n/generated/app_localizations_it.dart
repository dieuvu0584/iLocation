// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Cerca un luogo, città o indirizzo';

  @override
  String get searchButton => 'Cerca';

  @override
  String get searchRecent => 'Recenti';

  @override
  String get searchTryDemo => 'Prova una demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Nessun risultato trovato. Prova una ricerca diversa.';

  @override
  String get searchError =>
      'Qualcosa è andato storto. Controlla la connessione o prova la demo.';

  @override
  String get searchChooseMatch => 'Scegli un luogo';

  @override
  String get graphBack => 'Indietro';

  @override
  String get graphSettings => 'Impostazioni';

  @override
  String get graphHistory => 'Cronologia';

  @override
  String get graphRefresh => 'Aggiorna';

  @override
  String get graphRefreshAll => 'Aggiorna tutto';

  @override
  String get graphLoading => 'Raccolta informazioni…';

  @override
  String get graphError => 'Impossibile caricare questo luogo.';

  @override
  String get graphRetry => 'Riprova';

  @override
  String get detailSourceLlm => 'Riassunto dall\'IA';

  @override
  String get detailSourceApi => 'Dati in tempo reale';

  @override
  String get detailSourceStatic => 'Dati di riferimento';

  @override
  String get detailSourceSearch => 'Risultati di ricerca grezzi';

  @override
  String get detailSourceMissingKey => 'Richiede chiave API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Aggiornato $date';
  }

  @override
  String get detailStale =>
      'Vengono mostrati dati in cache meno recenti — aggiornamento non riuscito';

  @override
  String get detailSources => 'Fonti';

  @override
  String get detailNoData => 'Nessuna informazione disponibile al momento.';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsLanguageUnits => 'Lingua e unità';

  @override
  String get settingsLanguageUnitsDesc =>
      'Lingua dell\'interfaccia, lingua dei contenuti, unità di distanza/temperatura';

  @override
  String get settingsApiKeys => 'Chiavi API';

  @override
  String get settingsApiKeysDesc =>
      'Meteo e ricerca — luoghi/geocodifica non richiedono chiave';

  @override
  String get settingsAiAssistant => 'Assistente IA';

  @override
  String get settingsAiAssistantDesc =>
      'La tua chiave API LLM, livello di dettaglio, fonti';

  @override
  String get settingsDataPrivacy => 'Dati e privacy';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, cronologia, permesso di posizione, movimento, dimensione carattere';

  @override
  String get languageSettingsTitle => 'Lingua e unità';

  @override
  String get uiLanguage => 'Lingua dell\'app';

  @override
  String get contentLanguage => 'Lingua dei contenuti';

  @override
  String get contentLanguageDesc =>
      'Lingua usata per i contenuti riassunti dall\'IA — può differire dalla lingua dell\'app';

  @override
  String get distanceUnit => 'Unità di distanza';

  @override
  String get temperatureUnit => 'Unità di temperatura';

  @override
  String get currencyFormat => 'Formato valuta';

  @override
  String get km => 'Chilometri';

  @override
  String get miles => 'Miglia';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Predefinito di sistema';

  @override
  String get apiKeysTitle => 'Chiavi API';

  @override
  String get placesNoKeyNote =>
      'Ricerca, luoghi nelle vicinanze e l\'aeroporto più vicino usano OpenStreetMap (Nominatim + Overpass) — gratis, nessuna chiave API richiesta.';

  @override
  String get weatherApiKeyLabel => 'Chiave API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Necessaria per il meteo attuale.';

  @override
  String get searchApiKeyLabel => 'Chiave API di ricerca Tavily (facoltativa)';

  @override
  String get searchApiKeyDesc =>
      'Basa le risposte riassunte dall\'IA su risultati di ricerca reali. Senza di essa, l\'IA risponde solo con conoscenze generali.';

  @override
  String get llmSettingsTitle => 'Assistente IA';

  @override
  String get llmEnabled => 'Attiva riassunti IA';

  @override
  String get llmEnabledDesc =>
      'Quando disattivato, questi elementi restano semplicemente vuoti invece di chiamare un LLM';

  @override
  String get byokProviderLabel => 'Fornitore';

  @override
  String get byokApiKey => 'Chiave API';

  @override
  String get byokApiKeyHint =>
      'Salvata in modo sicuro solo su questo dispositivo';

  @override
  String get detailLevel => 'Livello di dettaglio';

  @override
  String get detailLevelShort => 'Breve';

  @override
  String get detailLevelDetailed => 'Dettagliato';

  @override
  String get showSources => 'Mostra fonti';

  @override
  String get showSourcesDesc => 'Mostra i link su cui si basano i riassunti IA';

  @override
  String get llmDisclaimer =>
      'I contenuti contrassegnati come \"Riassunto dall\'IA\" potrebbero non essere accurati. Verifica sempre le informazioni su visto, salute e sicurezza con fonti ufficiali.';

  @override
  String get privacySettingsTitle => 'Dati e privacy';

  @override
  String get cacheSize => 'Dimensione cache';

  @override
  String get clearCache => 'Svuota cache';

  @override
  String get clearCacheConfirm =>
      'Questo rimuoverà tutti i dati sui luoghi memorizzati nella cache. Continuare?';

  @override
  String get locationHistory => 'Cronologia luoghi';

  @override
  String get clearHistory => 'Cancella cronologia';

  @override
  String get clearHistoryConfirm =>
      'Questo rimuoverà la tua cronologia di ricerca. Continuare?';

  @override
  String get gpsPermission => 'Usa la mia posizione';

  @override
  String get gpsPermissionDesc =>
      'Usato per trovare luoghi entro 15 km da te. Puoi sempre cercare manualmente in alternativa.';

  @override
  String get reducedMotion => 'Riduci movimento';

  @override
  String get reducedMotionDesc =>
      'Disattiva l\'animazione ambientale nel grafo dei nodi';

  @override
  String get fontSize => 'Dimensione carattere';

  @override
  String get historyTitle => 'Cronologia';

  @override
  String get historyEmpty => 'Nessun luogo ancora cercato.';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get close => 'Chiudi';

  @override
  String get groupExplore => 'Esplora';

  @override
  String get groupPractical => 'Pratico';

  @override
  String get groupSafety => 'Sicurezza e salute';

  @override
  String get groupCulture => 'Cultura';

  @override
  String get groupEntryStay => 'Ingresso e soggiorno';
}
