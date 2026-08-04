import '../models/location_models.dart';
import '../models/settings_models.dart';
import 'cache_service.dart';
import 'emergency_service.dart';
import 'llm_service.dart';
import 'places_service.dart';
import 'timezone_service.dart';
import 'weather_service.dart';
import 'web_search_service.dart';

/// Dart port of the original backend's `app/services/orchestrator.py`:
/// cache-first, then fetch whatever's missing from the right on-device
/// service, write-through to the local `sqflite` cache. Everything now
/// runs on the phone — see CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt 2)".
class OrchestratorService {
  final CacheService _cache;
  final PlacesService _places;
  final WeatherService _weather;
  final TimezoneService _timezone;
  final EmergencyService _emergency;
  final WebSearchService _search;
  final LlmService _llm;

  OrchestratorService({
    CacheService? cache,
    PlacesService? places,
    WeatherService? weather,
    TimezoneService? timezone,
    EmergencyService? emergency,
    WebSearchService? search,
    LlmService? llm,
  })  : _cache = cache ?? CacheService(),
        _places = places ?? PlacesService(),
        _weather = weather ?? WeatherService(),
        _timezone = timezone ?? TimezoneService(),
        _emergency = emergency ?? EmergencyService(),
        _search = search ?? WebSearchService(),
        _llm = llm ?? LlmService();

  ChildItem _missingKeyItem(String itemId, String providerLabel) {
    return ChildItem(
      id: itemId,
      label: kChildLabels[itemId]!,
      source: 'missing_key',
      summary: 'Add your $providerLabel API key in Settings to see this.',
      detail: '',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  Future<ChildItem?> _fetchApiItem(String itemId, LocationInfo location, RequestSettings settings) async {
    if (!settings.hasPlacesKey && (itemId == 'places' || itemId == 'airport')) {
      return _missingKeyItem(itemId, 'Google Places');
    }
    if (!settings.hasWeatherKey && itemId == 'weather') {
      return _missingKeyItem(itemId, 'Weather');
    }
    try {
      if (itemId == 'places') return await _places.getNearbyPlaces(location.lat, location.lng, settings.placesApiKey!);
      if (itemId == 'weather') return await _weather.getWeather(location.lat, location.lng, settings.weatherApiKey!);
      if (itemId == 'airport') return await _places.getNearestAirport(location.lat, location.lng, settings.placesApiKey!);
    } catch (_) {
      return null;
    }
    return null;
  }

  Future<ChildItem?> _fetchLlmItem(String itemId, LocationInfo location, RequestSettings settings) async {
    if (!settings.llmEnabled) return null;
    if (!settings.hasLlmKey) return _missingKeyItem(itemId, 'LLM (AI Assistant)');

    final query = LlmService.searchQueryTemplates[itemId]!.replaceAll('{name}', location.name);
    var results = <WebSearchResult>[];
    if (settings.hasSearchKey) {
      try {
        results = await _search.search(query, settings.searchApiKey!);
      } catch (_) {
        results = [];
      }
    }

    var extraContext = '';
    if (itemId == 'health' && settings.hasPlacesKey) {
      try {
        extraContext = await _places.getNearestHospitalSnippet(location.lat, location.lng, settings.placesApiKey!);
      } catch (_) {
        // best-effort grounding only
      }
    }

    try {
      return await _llm.summarizeItem(
        itemId: itemId,
        locationName: location.name,
        searchResults: results,
        provider: settings.llmProvider.apiValue,
        apiKey: settings.llmApiKey!,
        detailLevel: settings.detailLevel.apiValue,
        showSources: settings.showSources,
        contentLanguage: settings.contentLanguage,
        extraContext: extraContext,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _resolveItem(
    String itemId,
    String groupId,
    LocationInfo location,
    RequestSettings settings,
    bool forceRefresh,
  ) async {
    if (!forceRefresh) {
      final cached = await _cache.getItem(location.id, itemId);
      if (cached != null) return;
    }

    ChildItem? fresh;
    if (kApiItemIds.contains(itemId)) {
      fresh = await _fetchApiItem(itemId, location, settings);
    } else if (kStaticItemIds.contains(itemId)) {
      fresh = itemId == 'emergency'
          ? await _emergency.getEmergencyItem(location.countryCode)
          : _timezone.getTimezoneItem(location.lat, location.lng);
    } else {
      fresh = await _fetchLlmItem(itemId, location, settings);
    }

    if (fresh != null) {
      await _cache.putItem(location.id, groupId, fresh);
      return;
    }

    if (!forceRefresh) {
      final stale = await _cache.getItemEvenIfStale(location.id, itemId);
      if (stale != null) await _cache.putItem(location.id, groupId, stale);
    }
  }

  Future<LocationResponse> buildLocationResponse(
    LocationSearchCandidate candidate,
    RequestSettings settings, {
    Set<String>? forceRefreshItems,
  }) async {
    final location = LocationInfo(
      id: candidate.locationId,
      name: candidate.name,
      lat: candidate.lat,
      lng: candidate.lng,
      countryCode: candidate.countryCode,
    );
    await _cache.upsertLocation(location);

    final refresh = forceRefreshItems ?? const {};
    final futures = <Future<void>>[];
    for (final entry in kChildIdsByGroup.entries) {
      for (final itemId in entry.value) {
        futures.add(_resolveItem(itemId, entry.key, location, settings, refresh.contains(itemId)));
      }
    }
    await Future.wait(futures);

    final result = await _cache.getFullLocation(location.id);
    return result ?? LocationResponse(location: location, cachedAt: DateTime.now().toUtc(), groups: const []);
  }

  Future<void> refreshItem(LocationSearchCandidate candidate, String itemId, RequestSettings settings) async {
    String? groupId;
    for (final entry in kChildIdsByGroup.entries) {
      if (entry.value.contains(itemId)) {
        groupId = entry.key;
        break;
      }
    }
    if (groupId == null) return;
    final location = LocationInfo(
      id: candidate.locationId,
      name: candidate.name,
      lat: candidate.lat,
      lng: candidate.lng,
      countryCode: candidate.countryCode,
    );
    await _resolveItem(itemId, groupId, location, settings, true);
  }
}
