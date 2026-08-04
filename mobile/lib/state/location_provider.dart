import 'package:flutter/foundation.dart';

import '../data/mock_location.dart';
import '../models/location_models.dart';
import '../services/history_service.dart';
import '../services/orchestrator_service.dart';
import 'app_settings.dart';

enum LocationLoadStatus { idle, loading, loaded, error }

/// Drives the node-graph screen: holds the currently-loaded LocationResponse
/// and mediates fetch/refresh calls through the on-device orchestrator (no
/// backend — CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt 2)").
class LocationProvider extends ChangeNotifier {
  final OrchestratorService _orchestrator;
  final HistoryService _historyService;
  final AppSettings _appSettings;

  LocationProvider({
    required OrchestratorService orchestrator,
    required HistoryService historyService,
    required AppSettings appSettings,
  })  : _orchestrator = orchestrator,
        _historyService = historyService,
        _appSettings = appSettings;

  LocationLoadStatus status = LocationLoadStatus.idle;
  LocationResponse? response;
  LocationSearchCandidate? candidate;
  String? errorMessage;

  /// Set of item ids currently being refreshed individually, so the UI can
  /// show a per-node spinner instead of a full-screen loading state.
  final Set<String> refreshingItemIds = {};

  static final Set<String> _allItemIds = {for (final ids in kChildIdsByGroup.values) ...ids};

  Future<void> load(LocationSearchCandidate newCandidate) async {
    candidate = newCandidate;
    status = LocationLoadStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final settings = await _appSettings.buildRequestSettings();
      response = await _orchestrator.buildLocationResponse(newCandidate, settings);
      status = LocationLoadStatus.loaded;
      await _historyService.add(newCandidate);
    } catch (e) {
      errorMessage = e.toString();
      status = LocationLoadStatus.error;
    }
    notifyListeners();
  }

  void loadMock() {
    candidate = mockCandidate;
    response = buildMockLocationResponse();
    status = LocationLoadStatus.loaded;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> refreshAll() async {
    if (candidate == null) return;
    status = LocationLoadStatus.loading;
    notifyListeners();
    try {
      final settings = await _appSettings.buildRequestSettings();
      response = await _orchestrator.buildLocationResponse(candidate!, settings, forceRefreshItems: _allItemIds);
      status = LocationLoadStatus.loaded;
    } catch (e) {
      errorMessage = e.toString();
      status = LocationLoadStatus.error;
    }
    notifyListeners();
  }

  Future<void> refreshItem(String itemId) async {
    if (candidate == null) return;
    refreshingItemIds.add(itemId);
    notifyListeners();
    try {
      final settings = await _appSettings.buildRequestSettings();
      await _orchestrator.refreshItem(candidate!, itemId, settings);
      response = await _orchestrator.buildLocationResponse(candidate!, settings);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      refreshingItemIds.remove(itemId);
      notifyListeners();
    }
  }

  void reset() {
    status = LocationLoadStatus.idle;
    response = null;
    candidate = null;
    errorMessage = null;
    notifyListeners();
  }
}
