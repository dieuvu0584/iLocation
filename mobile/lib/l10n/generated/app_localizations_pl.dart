// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Wyszukaj miejsce, miasto lub adres';

  @override
  String get searchButton => 'Szukaj';

  @override
  String get searchRecent => 'Ostatnie';

  @override
  String get searchTryDemo => 'Wypróbuj demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Nie znaleziono wyników. Spróbuj innego wyszukiwania.';

  @override
  String get searchError =>
      'Coś poszło nie tak. Sprawdź połączenie lub wypróbuj demo.';

  @override
  String get searchChooseMatch => 'Wybierz miejsce';

  @override
  String get graphBack => 'Wstecz';

  @override
  String get graphSettings => 'Ustawienia';

  @override
  String get graphHistory => 'Historia';

  @override
  String get graphRefresh => 'Odśwież';

  @override
  String get graphRefreshAll => 'Odśwież wszystko';

  @override
  String get graphLoading => 'Zbieranie informacji…';

  @override
  String get graphError => 'Nie można załadować tego miejsca.';

  @override
  String get graphRetry => 'Spróbuj ponownie';

  @override
  String get detailSourceLlm => 'Podsumowane przez AI';

  @override
  String get detailSourceApi => 'Dane na żywo';

  @override
  String get detailSourceStatic => 'Dane referencyjne';

  @override
  String get detailSourceSearch => 'Surowe wyniki wyszukiwania';

  @override
  String get detailSourceMissingKey => 'Wymaga klucza API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Zaktualizowano $date';
  }

  @override
  String get detailStale =>
      'Wyświetlane są starsze dane z pamięci podręcznej — odświeżanie nie powiodło się';

  @override
  String get detailSources => 'Źródła';

  @override
  String get detailNoData => 'Brak dostępnych informacji.';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get settingsLanguageUnits => 'Język i jednostki';

  @override
  String get settingsLanguageUnitsDesc =>
      'Język interfejsu, język treści, jednostki odległości/temperatury';

  @override
  String get settingsApiKeys => 'Klucze API';

  @override
  String get settingsApiKeysDesc =>
      'Pogoda i wyszukiwanie — miejsca/geokodowanie nie wymagają klucza';

  @override
  String get settingsAiAssistant => 'Asystent AI';

  @override
  String get settingsAiAssistantDesc =>
      'Twój własny klucz API LLM, poziom szczegółowości, źródła';

  @override
  String get settingsDataPrivacy => 'Dane i prywatność';

  @override
  String get settingsDataPrivacyDesc =>
      'Pamięć podręczna, historia, zgoda na lokalizację, ruch, rozmiar czcionki';

  @override
  String get languageSettingsTitle => 'Język i jednostki';

  @override
  String get uiLanguage => 'Język aplikacji';

  @override
  String get contentLanguage => 'Język treści';

  @override
  String get contentLanguageDesc =>
      'Język używany do treści podsumowywanych przez AI — może różnić się od języka aplikacji';

  @override
  String get distanceUnit => 'Jednostka odległości';

  @override
  String get temperatureUnit => 'Jednostka temperatury';

  @override
  String get currencyFormat => 'Format waluty';

  @override
  String get km => 'Kilometry';

  @override
  String get miles => 'Mile';

  @override
  String get celsius => 'Celsjusz (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Domyślne systemowe';

  @override
  String get apiKeysTitle => 'Klucze API';

  @override
  String get placesNoKeyNote =>
      'Wyszukiwanie, pobliskie miejsca i najbliższe lotnisko działają na OpenStreetMap (Nominatim + Overpass) — za darmo, bez klucza API.';

  @override
  String get weatherApiKeyLabel => 'Klucz API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Wymagany dla aktualnej pogody.';

  @override
  String get searchApiKeyLabel => 'Klucz API wyszukiwania Tavily (opcjonalnie)';

  @override
  String get searchApiKeyDesc =>
      'Opiera odpowiedzi podsumowywane przez AI na rzeczywistych wynikach wyszukiwania. Bez niego AI odpowiada wyłącznie na podstawie wiedzy ogólnej.';

  @override
  String get llmSettingsTitle => 'Asystent AI';

  @override
  String get llmEnabled => 'Włącz podsumowania AI';

  @override
  String get llmEnabledDesc =>
      'Gdy wyłączone, te pozycje pozostają puste zamiast wywoływać LLM';

  @override
  String get byokProviderLabel => 'Dostawca';

  @override
  String get byokApiKey => 'Klucz API';

  @override
  String get byokApiKeyHint =>
      'Przechowywany bezpiecznie tylko na tym urządzeniu';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Poziom szczegółowości';

  @override
  String get detailLevelShort => 'Krótko';

  @override
  String get detailLevelDetailed => 'Szczegółowo';

  @override
  String get showSources => 'Pokaż źródła';

  @override
  String get showSourcesDesc =>
      'Pokaż linki, na których oparto podsumowania AI';

  @override
  String get llmDisclaimer =>
      'Treści oznaczone jako „Podsumowane przez AI” mogą być niedokładne. Zawsze sprawdzaj informacje o wizach, zdrowiu i bezpieczeństwie w oficjalnych źródłach.';

  @override
  String get privacySettingsTitle => 'Dane i prywatność';

  @override
  String get cacheSize => 'Rozmiar pamięci podręcznej';

  @override
  String get clearCache => 'Wyczyść pamięć podręczną';

  @override
  String get clearCacheConfirm =>
      'Spowoduje to usunięcie wszystkich zapisanych danych o miejscach. Kontynuować?';

  @override
  String get locationHistory => 'Historia miejsc';

  @override
  String get clearHistory => 'Wyczyść historię';

  @override
  String get clearHistoryConfirm =>
      'Spowoduje to usunięcie historii wyszukiwania. Kontynuować?';

  @override
  String get gpsPermission => 'Użyj mojej lokalizacji';

  @override
  String get gpsPermissionDesc =>
      'Używane do znajdowania miejsc w promieniu 15 km od Ciebie. Zawsze możesz zamiast tego wyszukiwać ręcznie.';

  @override
  String get reducedMotion => 'Ogranicz ruch';

  @override
  String get reducedMotionDesc => 'Wyłącz animację otoczenia w grafie węzłów';

  @override
  String get fontSize => 'Rozmiar czcionki';

  @override
  String get historyTitle => 'Historia';

  @override
  String get historyEmpty => 'Nie wyszukano jeszcze żadnych miejsc.';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get close => 'Zamknij';

  @override
  String get groupExplore => 'Odkrywaj';

  @override
  String get groupPractical => 'Praktyczne';

  @override
  String get groupSafety => 'Bezpieczeństwo i zdrowie';

  @override
  String get groupCulture => 'Kultura';

  @override
  String get groupEntryStay => 'Wjazd i pobyt';
}
