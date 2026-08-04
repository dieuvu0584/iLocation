import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_models.dart';
import 'cache_service.dart';

class GeocodeException implements Exception {
  final String message;
  GeocodeException(this.message);
  @override
  String toString() => message;
}

/// Google Geocoding API, called directly from the client (BYOK — see
/// CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt 2)"). Structured API only,
/// never touches the LLM.
class GeocodeService {
  static const _url = 'https://maps.googleapis.com/maps/api/geocode/json';

  Future<List<LocationSearchCandidate>> searchCandidates(String query, String apiKey) async {
    final uri = Uri.parse(_url).replace(queryParameters: {'address': query, 'key': apiKey});
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw GeocodeException('Geocoding request failed (${resp.statusCode})');
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final status = data['status'] as String?;
    if (status != 'OK' && status != 'ZERO_RESULTS') {
      throw GeocodeException('Geocoding failed: $status ${data['error_message'] ?? ''}');
    }

    final results = (data['results'] as List<dynamic>? ?? []);
    return results.map((r) {
      final result = r as Map<String, dynamic>;
      final location = (result['geometry'] as Map<String, dynamic>)['location'] as Map<String, dynamic>;
      final lat = (location['lat'] as num).toDouble();
      final lng = (location['lng'] as num).toDouble();
      final addressComponents = (result['address_components'] as List<dynamic>? ?? [])
          .map((e) => e as Map<String, dynamic>)
          .toList();
      final name = addressComponents.isNotEmpty ? addressComponents.first['long_name'] as String : query;

      return LocationSearchCandidate(
        locationId: CacheService.normalizeLocationId(lat, lng),
        name: name,
        formattedAddress: result['formatted_address'] as String? ?? query,
        lat: lat,
        lng: lng,
        countryCode: _countryCode(addressComponents),
      );
    }).toList();
  }

  String? _countryCode(List<Map<String, dynamic>> components) {
    for (final comp in components) {
      final types = (comp['types'] as List<dynamic>? ?? []).cast<String>();
      if (types.contains('country')) return comp['short_name'] as String?;
    }
    return null;
  }
}
