import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

import '../models/location_models.dart';
import '../models/settings_models.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Talks to the FastAPI backend (backend/app/api/routes). Base URL can be
/// overridden at build time with `--dart-define=API_BASE_URL=...`, or at
/// runtime via [updateBaseUrl] (wired to the Privacy settings screen) —
/// the platform default below only makes sense on an emulator/simulator,
/// never on a real device, which has no way to reach a `10.0.2.2` or
/// `localhost` that means "my host machine".
class ApiClient {
  static const _defaultBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: '');

  String baseUrl;
  final http.Client _client;

  ApiClient({String? baseUrl, http.Client? client})
      : baseUrl = baseUrl ?? (_defaultBaseUrl.isNotEmpty ? _defaultBaseUrl : _platformDefaultBaseUrl()),
        _client = client ?? http.Client();

  /// Called at startup (with the saved setting) and whenever the user edits
  /// the server URL in Privacy settings. Passing null/empty resets to the
  /// build-time/platform default.
  void updateBaseUrl(String? url) {
    baseUrl = (url != null && url.trim().isNotEmpty)
        ? url.trim()
        : (_defaultBaseUrl.isNotEmpty ? _defaultBaseUrl : _platformDefaultBaseUrl());
  }

  static String _platformDefaultBaseUrl() {
    if (kIsWeb) return 'http://localhost:8000';
    try {
      if (Platform.isAndroid) return 'http://10.0.2.2:8000';
    } catch (_) {
      // Platform is unavailable in some test environments.
    }
    return 'http://localhost:8000';
  }

  Uri _uri(String path, [Map<String, String>? query]) => Uri.parse('$baseUrl$path').replace(queryParameters: query);

  Future<List<LocationSearchCandidate>> searchLocations(String query) async {
    final resp = await _client.post(
      _uri('/api/v1/locations/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query}),
    );
    _checkOk(resp);
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    return (data['candidates'] as List<dynamic>)
        .map((e) => LocationSearchCandidate.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<LocationResponse> resolveLocation(
    LocationSearchCandidate candidate,
    LlmRequestSettings settings,
  ) async {
    final resp = await _client.post(
      _uri('/api/v1/locations/${candidate.locationId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'candidate': candidate.toJson(), 'settings': settings.toJson()}),
    );
    _checkOk(resp);
    return LocationResponse.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
  }

  Future<LocationResponse> refreshLocation(
    LocationSearchCandidate candidate,
    LlmRequestSettings settings, {
    String? itemId,
  }) async {
    final resp = await _client.post(
      _uri('/api/v1/locations/${candidate.locationId}/refresh', itemId != null ? {'item_id': itemId} : null),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'candidate': candidate.toJson(), 'settings': settings.toJson()}),
    );
    _checkOk(resp);
    return LocationResponse.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getLlmUsage(String deviceId) async {
    final resp = await _client.get(_uri('/api/v1/llm/usage', {'device_id': deviceId}));
    _checkOk(resp);
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getCacheStats() async {
    final resp = await _client.get(_uri('/api/v1/cache/stats'));
    _checkOk(resp);
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  Future<void> clearCache() async {
    final resp = await _client.delete(_uri('/api/v1/cache'));
    _checkOk(resp);
  }

  void _checkOk(http.Response resp) {
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      String detail = resp.body;
      try {
        final decoded = jsonDecode(resp.body);
        if (decoded is Map && decoded['detail'] != null) detail = decoded['detail'].toString();
      } catch (_) {
        // body wasn't JSON — use raw text.
      }
      throw ApiException(detail, statusCode: resp.statusCode);
    }
  }
}
