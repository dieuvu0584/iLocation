import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart' as http;

import '../models/location_models.dart';

class PlacesException implements Exception {
  final String message;
  PlacesException(this.message);
  @override
  String toString() => message;
}

/// OpenStreetMap Overpass API — free, no API key required (swapped from
/// Google Places per project owner request; see CLAUDE.md "Quyết định đã
/// chốt 2026-08-04 (đợt 3)"). Structured data only, never touches the LLM.
///
/// This is a shared public instance (overpass-api.de) with its own fair-use
/// limits — occasional slowness or a timeout under load is the tradeoff for
/// not needing a key. `around:RADIUS_M,LAT,LNG` filters by radius but does
/// NOT sort by distance, so results are sorted client-side with a Haversine
/// calculation below.
class PlacesService {
  static const _url = 'https://overpass-api.de/api/interpreter';

  double _distanceMeters(double lat1, double lng1, double lat2, double lng2) {
    const earthRadiusM = 6371000.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLng = _degToRad(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(lat1)) * math.cos(_degToRad(lat2)) * math.sin(dLng / 2) * math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusM * c;
  }

  double _degToRad(double deg) => deg * (math.pi / 180);

  Future<List<Map<String, dynamic>>> _query(String overpassQl) async {
    final resp = await http.post(Uri.parse(_url), body: {'data': overpassQl});
    if (resp.statusCode != 200) {
      throw PlacesException('Overpass query failed (${resp.statusCode})');
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    return (data['elements'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
  }

  /// Named elements only, sorted nearest-first.
  List<Map<String, dynamic>> _namedSortedByDistance(List<Map<String, dynamic>> elements, double lat, double lng) {
    final named = elements.where((e) {
      final tags = e['tags'] as Map<String, dynamic>?;
      return tags != null && (tags['name'] as String?)?.isNotEmpty == true;
    }).toList();
    named.sort((a, b) {
      final da = _distanceMeters(lat, lng, (a['lat'] as num).toDouble(), (a['lon'] as num).toDouble());
      final db = _distanceMeters(lat, lng, (b['lat'] as num).toDouble(), (b['lon'] as num).toDouble());
      return da.compareTo(db);
    });
    return named;
  }

  Future<ChildItem> getNearbyPlaces(double lat, double lng) async {
    final query = '''
[out:json][timeout:25];
(
  node["tourism"](around:15000,$lat,$lng);
  node["amenity"~"^(restaurant|cafe|museum|marketplace|place_of_worship|theatre)\$"](around:15000,$lat,$lng);
);
out body 40;
''';
    final elements = await _query(query);
    final sorted = _namedSortedByDistance(elements, lat, lng);
    final top = sorted.take(10).toList();

    final summary = sorted.isNotEmpty ? '${sorted.length} places nearby' : 'No notable places found nearby';
    final detail = top.map((e) {
      final tags = e['tags'] as Map<String, dynamic>;
      final kind = (tags['tourism'] ?? tags['amenity'] ?? '') as String;
      return '- ${tags['name']}${kind.isNotEmpty ? ' ($kind)' : ''}';
    }).join('\n');

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

  Future<ChildItem> getNearestAirport(double lat, double lng) async {
    final query = '''
[out:json][timeout:25];
node["aeroway"="aerodrome"](around:100000,$lat,$lng);
out body 15;
''';
    final elements = await _query(query);
    final sorted = _namedSortedByDistance(elements, lat, lng);
    if (sorted.isEmpty) {
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
    final nearest = sorted.first;
    final tags = nearest['tags'] as Map<String, dynamic>;
    final distanceKm =
        (_distanceMeters(lat, lng, (nearest['lat'] as num).toDouble(), (nearest['lon'] as num).toDouble()) / 1000)
            .round();

    return ChildItem(
      id: 'airport',
      label: kChildLabels['airport']!,
      source: 'api',
      summary: tags['name'] as String,
      detail: '~${distanceKm}km away',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  /// Raw snippet used to ground the LLM-summarized `health` item (SDD §4:
  /// health = API Places + LLM).
  Future<String> getNearestHospitalSnippet(double lat, double lng) async {
    final query = '''
[out:json][timeout:25];
node["amenity"="hospital"](around:15000,$lat,$lng);
out body 10;
''';
    final elements = await _query(query);
    final sorted = _namedSortedByDistance(elements, lat, lng);
    if (sorted.isEmpty) return 'No hospital found within 15km (structured data).';
    final lines = sorted.take(5).map((e) => (e['tags'] as Map<String, dynamic>)['name']).join('\n');
    return 'Nearby hospitals (structured data):\n$lines';
  }
}
