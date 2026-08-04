import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_models.dart';

class PlacesException implements Exception {
  final String message;
  PlacesException(this.message);
  @override
  String toString() => message;
}

/// Google Places API (Nearby Search), called directly from the client
/// (BYOK). Structured API only, never touches the LLM.
class PlacesService {
  static const _url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  static const _nearbyRadiusMeters = 15000;

  Future<List<Map<String, dynamic>>> _nearbySearch(
    double lat,
    double lng,
    String type,
    int radiusMeters,
    String apiKey,
  ) async {
    final uri = Uri.parse(_url).replace(queryParameters: {
      'location': '$lat,$lng',
      'radius': '$radiusMeters',
      'type': type,
      'key': apiKey,
    });
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw PlacesException('Places search failed (${resp.statusCode})');
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final status = data['status'] as String?;
    if (status != 'OK' && status != 'ZERO_RESULTS') {
      throw PlacesException('Places search failed: $status ${data['error_message'] ?? ''}');
    }
    return (data['results'] as List<dynamic>? ?? []).map((e) => e as Map<String, dynamic>).toList();
  }

  Future<ChildItem> getNearbyPlaces(double lat, double lng, String apiKey) async {
    final results = await _nearbySearch(lat, lng, 'point_of_interest', _nearbyRadiusMeters, apiKey);
    final top = results.take(10).toList();
    final summary = results.isNotEmpty ? '${results.length} places nearby' : 'No notable places found nearby';
    final detail = top
        .map((r) => '- ${r['name']} (${r['rating'] ?? 'n/a'}★) — ${r['vicinity'] ?? ''}')
        .join('\n');

    return ChildItem(
      id: 'places',
      label: kChildLabels['places']!,
      source: 'api',
      summary: summary,
      detail: detail.isEmpty ? 'No data available.' : detail,
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  Future<ChildItem> getNearestAirport(double lat, double lng, String apiKey) async {
    final results = await _nearbySearch(lat, lng, 'airport', 100000, apiKey);
    if (results.isEmpty) {
      return ChildItem(
        id: 'airport',
        label: kChildLabels['airport']!,
        source: 'api',
        summary: 'No airport found within 100km',
        detail: '',
        sources: const [],
        updatedAt: DateTime.now().toUtc(),
      );
    }
    final nearest = results.first;
    return ChildItem(
      id: 'airport',
      label: kChildLabels['airport']!,
      source: 'api',
      summary: nearest['name'] as String,
      detail: nearest['vicinity'] as String? ?? '',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  /// Raw snippet used to ground the LLM-summarized `health` item (SDD §4:
  /// health = API Places + LLM).
  Future<String> getNearestHospitalSnippet(double lat, double lng, String apiKey) async {
    final results = await _nearbySearch(lat, lng, 'hospital', 15000, apiKey);
    if (results.isEmpty) return 'No hospital found within 15km (structured data).';
    final lines = results.take(5).map((r) => '${r['name']} — ${r['vicinity'] ?? ''}').join('\n');
    return 'Nearby hospitals (structured data):\n$lines';
  }
}
