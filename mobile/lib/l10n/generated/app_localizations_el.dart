// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Αναζήτηση τοποθεσίας, πόλης ή διεύθυνσης';

  @override
  String get searchButton => 'Αναζήτηση';

  @override
  String get searchRecent => 'Πρόσφατα';

  @override
  String get searchTryDemo => 'Δοκιμάστε μια επίδειξη (Da Lat)';

  @override
  String get searchNoResults =>
      'Δεν βρέθηκαν αποτελέσματα. Δοκιμάστε διαφορετική αναζήτηση.';

  @override
  String get searchError =>
      'Κάτι πήγε στραβά. Ελέγξτε τη σύνδεσή σας ή δοκιμάστε την επίδειξη.';

  @override
  String get searchChooseMatch => 'Επιλέξτε μια τοποθεσία';

  @override
  String get graphBack => 'Πίσω';

  @override
  String get graphSettings => 'Ρυθμίσεις';

  @override
  String get graphHistory => 'Ιστορικό';

  @override
  String get graphRefresh => 'Ανανέωση';

  @override
  String get graphRefreshAll => 'Ανανέωση όλων';

  @override
  String get graphLoading => 'Συλλογή πληροφοριών…';

  @override
  String get graphError => 'Δεν ήταν δυνατή η φόρτωση αυτής της τοποθεσίας.';

  @override
  String get graphRetry => 'Δοκιμάστε ξανά';

  @override
  String get detailSourceLlm => 'Σύνοψη από AI';

  @override
  String get detailSourceApi => 'Δεδομένα σε πραγματικό χρόνο';

  @override
  String get detailSourceStatic => 'Δεδομένα αναφοράς';

  @override
  String get detailSourceSearch => 'Ακατέργαστα αποτελέσματα αναζήτησης';

  @override
  String get detailSourceMissingKey => 'Απαιτείται κλειδί API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Ενημερώθηκε $date';
  }

  @override
  String get detailStale =>
      'Εμφανίζονται παλαιότερα δεδομένα προσωρινής αποθήκευσης — η ανανέωση απέτυχε';

  @override
  String get detailSources => 'Πηγές';

  @override
  String get detailNoData => 'Δεν υπάρχουν ακόμη διαθέσιμες πληροφορίες.';

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get settingsLanguageUnits => 'Γλώσσα και μονάδες';

  @override
  String get settingsLanguageUnitsDesc =>
      'Γλώσσα εφαρμογής, γλώσσα περιεχομένου, μονάδες απόστασης/θερμοκρασίας';

  @override
  String get settingsApiKeys => 'Κλειδιά API';

  @override
  String get settingsApiKeysDesc =>
      'Καιρός και αναζήτηση — τοποθεσίες/γεωκωδικοποίηση δεν χρειάζονται κλειδί';

  @override
  String get settingsAiAssistant => 'Βοηθός AI';

  @override
  String get settingsAiAssistantDesc =>
      'Το δικό σας κλειδί API LLM, επίπεδο λεπτομέρειας, πηγές';

  @override
  String get settingsDataPrivacy => 'Δεδομένα και απόρρητο';

  @override
  String get settingsDataPrivacyDesc =>
      'Προσωρινή αποθήκευση, ιστορικό, άδεια τοποθεσίας, κίνηση, μέγεθος γραμματοσειράς';

  @override
  String get languageSettingsTitle => 'Γλώσσα και μονάδες';

  @override
  String get uiLanguage => 'Γλώσσα εφαρμογής';

  @override
  String get contentLanguage => 'Γλώσσα περιεχομένου';

  @override
  String get contentLanguageDesc =>
      'Γλώσσα που χρησιμοποιείται για περιεχόμενο που συνοψίζεται από AI — μπορεί να διαφέρει από τη γλώσσα της εφαρμογής';

  @override
  String get distanceUnit => 'Μονάδα απόστασης';

  @override
  String get temperatureUnit => 'Μονάδα θερμοκρασίας';

  @override
  String get currencyFormat => 'Μορφή νομίσματος';

  @override
  String get km => 'Χιλιόμετρα';

  @override
  String get miles => 'Μίλια';

  @override
  String get celsius => 'Κελσίου (°C)';

  @override
  String get fahrenheit => 'Φαρενάιτ (°F)';

  @override
  String get systemDefault => 'Προεπιλογή συστήματος';

  @override
  String get apiKeysTitle => 'Κλειδιά API';

  @override
  String get placesNoKeyNote =>
      'Η αναζήτηση, οι κοντινές τοποθεσίες και το πλησιέστερο αεροδρόμιο λειτουργούν μέσω OpenStreetMap (Nominatim + Overpass) — δωρεάν, χωρίς να απαιτείται κλειδί API.';

  @override
  String get weatherApiKeyLabel => 'Κλειδί API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Απαιτείται για τον τρέχοντα καιρό.';

  @override
  String get searchApiKeyLabel => 'Κλειδί API αναζήτησης Tavily (προαιρετικό)';

  @override
  String get searchApiKeyDesc =>
      'Βασίζει τις απαντήσεις που συνοψίζονται από AI σε πραγματικά αποτελέσματα αναζήτησης. Χωρίς αυτό, το AI απαντά μόνο βάσει γενικών γνώσεων.';

  @override
  String get llmSettingsTitle => 'Βοηθός AI';

  @override
  String get llmEnabled => 'Ενεργοποίηση συνόψεων AI';

  @override
  String get llmEnabledDesc =>
      'Όταν είναι απενεργοποιημένο, αυτά τα στοιχεία απλώς παραμένουν κενά αντί να καλείται ένα LLM';

  @override
  String get byokProviderLabel => 'Πάροχος';

  @override
  String get byokApiKey => 'Κλειδί API';

  @override
  String get byokApiKeyHint =>
      'Αποθηκεύεται με ασφάλεια μόνο σε αυτή τη συσκευή';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Επίπεδο λεπτομέρειας';

  @override
  String get detailLevelShort => 'Σύντομο';

  @override
  String get detailLevelDetailed => 'Λεπτομερές';

  @override
  String get showSources => 'Εμφάνιση πηγών';

  @override
  String get showSourcesDesc =>
      'Εμφάνιση συνδέσμων στους οποίους βασίστηκαν οι συνόψεις AI';

  @override
  String get llmDisclaimer =>
      'Το περιεχόμενο που επισημαίνεται ως \"Σύνοψη από AI\" ενδέχεται να μην είναι ακριβές. Επαληθεύετε πάντα τις πληροφορίες για βίζα, υγεία και ασφάλεια από επίσημες πηγές.';

  @override
  String get privacySettingsTitle => 'Δεδομένα και απόρρητο';

  @override
  String get cacheSize => 'Μέγεθος προσωρινής αποθήκευσης';

  @override
  String get clearCache => 'Εκκαθάριση προσωρινής αποθήκευσης';

  @override
  String get clearCacheConfirm =>
      'Αυτό θα αφαιρέσει όλα τα δεδομένα τοποθεσιών στην προσωρινή αποθήκευση. Συνέχεια;';

  @override
  String get locationHistory => 'Ιστορικό τοποθεσιών';

  @override
  String get clearHistory => 'Εκκαθάριση ιστορικού';

  @override
  String get clearHistoryConfirm =>
      'Αυτό θα αφαιρέσει το ιστορικό αναζήτησής σας. Συνέχεια;';

  @override
  String get gpsPermission => 'Χρήση της τοποθεσίας μου';

  @override
  String get gpsPermissionDesc =>
      'Χρησιμοποιείται για την εύρεση τοποθεσιών εντός 15 χλμ από εσάς. Μπορείτε πάντα να αναζητήσετε χειροκίνητα εναλλακτικά.';

  @override
  String get reducedMotion => 'Μείωση κίνησης';

  @override
  String get reducedMotionDesc =>
      'Απενεργοποίηση κίνησης περιβάλλοντος στο γράφημα κόμβων';

  @override
  String get fontSize => 'Μέγεθος γραμματοσειράς';

  @override
  String get historyTitle => 'Ιστορικό';

  @override
  String get historyEmpty => 'Δεν έχουν αναζητηθεί ακόμη τοποθεσίες.';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get close => 'Κλείσιμο';

  @override
  String get groupExplore => 'Εξερεύνηση';

  @override
  String get groupPractical => 'Πρακτικά';

  @override
  String get groupSafety => 'Ασφάλεια και υγεία';

  @override
  String get groupCulture => 'Πολιτισμός';

  @override
  String get groupEntryStay => 'Είσοδος και διαμονή';
}
