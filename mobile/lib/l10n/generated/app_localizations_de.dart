// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Ort, Stadt oder Adresse suchen';

  @override
  String get searchButton => 'Suchen';

  @override
  String get searchRecent => 'Zuletzt verwendet';

  @override
  String get searchTryDemo => 'Demo ausprobieren (Da Lat)';

  @override
  String get searchNoResults =>
      'Keine Treffer gefunden. Versuche eine andere Suche.';

  @override
  String get searchError =>
      'Etwas ist schiefgelaufen. Prüfe deine Verbindung oder probiere die Demo.';

  @override
  String get searchChooseMatch => 'Ort auswählen';

  @override
  String get graphBack => 'Zurück';

  @override
  String get graphSettings => 'Einstellungen';

  @override
  String get graphHistory => 'Verlauf';

  @override
  String get graphRefresh => 'Aktualisieren';

  @override
  String get graphRefreshAll => 'Alles aktualisieren';

  @override
  String get graphLoading => 'Informationen werden gesammelt…';

  @override
  String get graphError => 'Dieser Ort konnte nicht geladen werden.';

  @override
  String get graphRetry => 'Erneut versuchen';

  @override
  String get detailSourceLlm => 'KI-Zusammenfassung';

  @override
  String get detailSourceApi => 'Live-Daten';

  @override
  String get detailSourceStatic => 'Referenzdaten';

  @override
  String get detailSourceSearch => 'Rohe Suchergebnisse';

  @override
  String get detailSourceMissingKey => 'API-Schlüssel benötigt';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String detailUpdatedAt(String date) {
    return 'Aktualisiert $date';
  }

  @override
  String get detailStale =>
      'Ältere zwischengespeicherte Daten werden angezeigt — Aktualisierung fehlgeschlagen';

  @override
  String get detailSources => 'Quellen';

  @override
  String get detailNoData => 'Noch keine Informationen verfügbar.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguageUnits => 'Sprache & Einheiten';

  @override
  String get settingsLanguageUnitsDesc =>
      'App-Sprache, Inhaltssprache, Entfernungs-/Temperatureinheiten';

  @override
  String get settingsApiKeys => 'API-Schlüssel';

  @override
  String get settingsApiKeysDesc =>
      'Wetter und Suche — Orte/Geokodierung benötigen keinen Schlüssel';

  @override
  String get settingsAiAssistant => 'KI-Assistent';

  @override
  String get settingsAiAssistantDesc =>
      'Dein eigener LLM-API-Schlüssel, Detailgrad, Quellen';

  @override
  String get settingsDataPrivacy => 'Daten & Datenschutz';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, Verlauf, Standortberechtigung, Bewegung, Schriftgröße';

  @override
  String get languageSettingsTitle => 'Sprache & Einheiten';

  @override
  String get uiLanguage => 'App-Sprache';

  @override
  String get contentLanguage => 'Inhaltssprache';

  @override
  String get contentLanguageDesc =>
      'Sprache für KI-zusammengefasste Inhalte — kann von der App-Sprache abweichen';

  @override
  String get distanceUnit => 'Entfernungseinheit';

  @override
  String get temperatureUnit => 'Temperatureinheit';

  @override
  String get currencyFormat => 'Währungsformat';

  @override
  String get km => 'Kilometer';

  @override
  String get miles => 'Meilen';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get apiKeysTitle => 'API-Schlüssel';

  @override
  String get placesNoKeyNote =>
      'Suche, Orte in der Nähe und der nächste Flughafen laufen über OpenStreetMap (Nominatim + Overpass) — kostenlos, kein API-Schlüssel nötig.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap-API-Schlüssel';

  @override
  String get weatherApiKeyDesc => 'Wird für das aktuelle Wetter benötigt.';

  @override
  String get searchApiKeyLabel => 'Tavily-Such-API-Schlüssel (optional)';

  @override
  String get searchApiKeyDesc =>
      'Untermauert KI-Zusammenfassungen mit echten Suchergebnissen. Ohne ihn antwortet die KI nur aus allgemeinem Wissen.';

  @override
  String get llmSettingsTitle => 'KI-Assistent';

  @override
  String get llmEnabled => 'KI-Zusammenfassungen aktivieren';

  @override
  String get llmEnabledDesc =>
      'Wenn deaktiviert, bleiben diese Elemente einfach leer, statt ein LLM aufzurufen';

  @override
  String get byokProviderLabel => 'Anbieter';

  @override
  String get byokApiKey => 'API-Schlüssel';

  @override
  String get byokApiKeyHint => 'Wird nur sicher auf diesem Gerät gespeichert';

  @override
  String get detailLevel => 'Detailgrad';

  @override
  String get detailLevelShort => 'Kurz';

  @override
  String get detailLevelDetailed => 'Ausführlich';

  @override
  String get showSources => 'Quellen anzeigen';

  @override
  String get showSourcesDesc =>
      'Links anzeigen, auf denen KI-Zusammenfassungen basieren';

  @override
  String get llmDisclaimer =>
      'Als „KI-Zusammenfassung“ markierte Inhalte können ungenau sein. Überprüfe Visa-, Gesundheits- und Sicherheitsinformationen immer bei offiziellen Quellen.';

  @override
  String get privacySettingsTitle => 'Daten & Datenschutz';

  @override
  String get cacheSize => 'Cache-Größe';

  @override
  String get clearCache => 'Cache leeren';

  @override
  String get clearCacheConfirm =>
      'Dadurch werden alle zwischengespeicherten Ortsdaten entfernt. Fortfahren?';

  @override
  String get locationHistory => 'Ortsverlauf';

  @override
  String get clearHistory => 'Verlauf löschen';

  @override
  String get clearHistoryConfirm =>
      'Dadurch wird dein Suchverlauf entfernt. Fortfahren?';

  @override
  String get gpsPermission => 'Meinen Standort verwenden';

  @override
  String get gpsPermissionDesc =>
      'Wird verwendet, um Orte innerhalb von 15 km um dich herum zu finden. Du kannst stattdessen immer manuell suchen.';

  @override
  String get reducedMotion => 'Bewegung reduzieren';

  @override
  String get reducedMotionDesc =>
      'Umgebungsanimation im Knotengraphen ausschalten';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get historyTitle => 'Verlauf';

  @override
  String get historyEmpty => 'Noch keine Orte nachgeschlagen.';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get close => 'Schließen';

  @override
  String get groupExplore => 'Entdecken';

  @override
  String get groupPractical => 'Praktisches';

  @override
  String get groupSafety => 'Sicherheit & Gesundheit';

  @override
  String get groupCulture => 'Kultur';

  @override
  String get groupEntryStay => 'Einreise & Aufenthalt';
}
