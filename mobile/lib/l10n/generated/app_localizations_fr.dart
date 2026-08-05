// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Rechercher un lieu, une ville ou une adresse';

  @override
  String get searchButton => 'Rechercher';

  @override
  String get searchRecent => 'Récents';

  @override
  String get searchTryDemo => 'Essayer une démo (Da Lat)';

  @override
  String get searchNoResults =>
      'Aucun résultat trouvé. Essayez une autre recherche.';

  @override
  String get searchError =>
      'Une erreur s\'est produite. Vérifiez votre connexion ou essayez la démo.';

  @override
  String get searchChooseMatch => 'Choisir un lieu';

  @override
  String get graphBack => 'Retour';

  @override
  String get graphSettings => 'Paramètres';

  @override
  String get graphHistory => 'Historique';

  @override
  String get graphRefresh => 'Actualiser';

  @override
  String get graphRefreshAll => 'Tout actualiser';

  @override
  String get graphLoading => 'Rassemblement des informations…';

  @override
  String get graphError => 'Impossible de charger ce lieu.';

  @override
  String get graphRetry => 'Réessayer';

  @override
  String get detailSourceLlm => 'Résumé par IA';

  @override
  String get detailSourceApi => 'Données en direct';

  @override
  String get detailSourceStatic => 'Données de référence';

  @override
  String get detailSourceSearch => 'Résultats de recherche bruts';

  @override
  String get detailSourceMissingKey => 'Clé API requise';

  @override
  String detailUpdatedAt(String date) {
    return 'Mis à jour $date';
  }

  @override
  String get detailStale =>
      'Affichage de données en cache plus anciennes — l\'actualisation a échoué';

  @override
  String get detailSources => 'Sources';

  @override
  String get detailNoData => 'Aucune information disponible pour le moment.';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguageUnits => 'Langue et unités';

  @override
  String get settingsLanguageUnitsDesc =>
      'Langue de l\'interface, langue du contenu, unités de distance/température';

  @override
  String get settingsApiKeys => 'Clés API';

  @override
  String get settingsApiKeysDesc =>
      'Météo et recherche — lieux/géocodage ne nécessitent aucune clé';

  @override
  String get settingsAiAssistant => 'Assistant IA';

  @override
  String get settingsAiAssistantDesc =>
      'Votre propre clé API LLM, niveau de détail, sources';

  @override
  String get settingsDataPrivacy => 'Données et confidentialité';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, historique, autorisation de localisation, mouvement, taille de police';

  @override
  String get languageSettingsTitle => 'Langue et unités';

  @override
  String get uiLanguage => 'Langue de l\'application';

  @override
  String get contentLanguage => 'Langue du contenu';

  @override
  String get contentLanguageDesc =>
      'Langue utilisée pour le contenu résumé par l\'IA — peut différer de la langue de l\'application';

  @override
  String get distanceUnit => 'Unité de distance';

  @override
  String get temperatureUnit => 'Unité de température';

  @override
  String get currencyFormat => 'Format de devise';

  @override
  String get km => 'Kilomètres';

  @override
  String get miles => 'Miles';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get apiKeysTitle => 'Clés API';

  @override
  String get placesNoKeyNote =>
      'La recherche, les lieux à proximité et l\'aéroport le plus proche utilisent OpenStreetMap (Nominatim + Overpass) — gratuit, aucune clé API requise.';

  @override
  String get weatherApiKeyLabel => 'Clé API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Nécessaire pour la météo actuelle.';

  @override
  String get searchApiKeyLabel => 'Clé API de recherche Tavily (facultatif)';

  @override
  String get searchApiKeyDesc =>
      'Fonde les réponses résumées par l\'IA sur de vrais résultats de recherche. Sans elle, l\'IA répond uniquement à partir de connaissances générales.';

  @override
  String get llmSettingsTitle => 'Assistant IA';

  @override
  String get llmEnabled => 'Activer les résumés IA';

  @override
  String get llmEnabledDesc =>
      'Lorsque désactivé, ces éléments sont simplement laissés vides au lieu d\'appeler un LLM';

  @override
  String get byokProviderLabel => 'Fournisseur';

  @override
  String get byokApiKey => 'Clé API';

  @override
  String get byokApiKeyHint =>
      'Stockée en sécurité uniquement sur cet appareil';

  @override
  String get detailLevel => 'Niveau de détail';

  @override
  String get detailLevelShort => 'Court';

  @override
  String get detailLevelDetailed => 'Détaillé';

  @override
  String get showSources => 'Afficher les sources';

  @override
  String get showSourcesDesc =>
      'Afficher les liens sur lesquels les résumés IA sont basés';

  @override
  String get llmDisclaimer =>
      'Le contenu marqué « Résumé par IA » peut être inexact. Vérifiez toujours les informations de visa, de santé et de sécurité auprès de sources officielles.';

  @override
  String get privacySettingsTitle => 'Données et confidentialité';

  @override
  String get cacheSize => 'Taille du cache';

  @override
  String get clearCache => 'Vider le cache';

  @override
  String get clearCacheConfirm =>
      'Cela supprimera toutes les données de lieux mises en cache. Continuer ?';

  @override
  String get locationHistory => 'Historique des lieux';

  @override
  String get clearHistory => 'Effacer l\'historique';

  @override
  String get clearHistoryConfirm =>
      'Cela supprimera votre historique de recherche. Continuer ?';

  @override
  String get gpsPermission => 'Utiliser ma position';

  @override
  String get gpsPermissionDesc =>
      'Utilisé pour trouver des lieux dans un rayon de 15 km autour de vous. Vous pouvez toujours effectuer une recherche manuelle à la place.';

  @override
  String get reducedMotion => 'Réduire les animations';

  @override
  String get reducedMotionDesc =>
      'Désactiver l\'animation ambiante dans le graphe de nœuds';

  @override
  String get fontSize => 'Taille de police';

  @override
  String get historyTitle => 'Historique';

  @override
  String get historyEmpty => 'Aucun lieu recherché pour l\'instant.';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get close => 'Fermer';

  @override
  String get groupExplore => 'Explorer';

  @override
  String get groupPractical => 'Pratique';

  @override
  String get groupSafety => 'Sécurité et santé';

  @override
  String get groupCulture => 'Culture';

  @override
  String get groupEntryStay => 'Entrée et séjour';
}
