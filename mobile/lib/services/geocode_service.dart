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

/// OpenStreetMap Nominatim — free, no API key required (swapped from Google
/// Geocoding per project owner request; see CLAUDE.md "Quyết định đã chốt
/// 2026-08-04 (đợt 3)"). Structured API only, never touches the LLM.
///
/// Usage policy (https://operations.osmfoundation.org/policies/nominatim/)
/// caps a single app at ~1 request/second and requires an identifying
/// User-Agent — satisfied here via an identifying header and a debounce on
/// the caller side (search_screen.dart fires on a pause in typing, not per
/// keystroke). This is a shared public instance, so it can be slower or
/// briefly unavailable under load; that's the tradeoff for not needing a key.
class GeocodeService {
  static const _url = 'https://nominatim.openstreetmap.org/search';
  static const _userAgent = 'iLocationExplorerApp/1.0 (personal travel info app; BYOK, no server)';

  /// [acceptLanguage] is a BCP-47 language code (e.g. `vi`, `en`, `fr`) —
  /// pass the app's UI/device locale so `display_name`/`name` come back
  /// translated into it where OpenStreetMap has a `name:<lang>` tag for the
  /// place. `namedetails=1` additionally returns the untranslated local
  /// name, so callers can show both (see `LocationSearchCandidate.localName`).
  Future<List<LocationSearchCandidate>> searchCandidates(String query, {String? acceptLanguage}) async {
    final uri = Uri.parse(_url).replace(queryParameters: {
      'q': query,
      'format': 'jsonv2',
      'addressdetails': '1',
      'namedetails': '1',
      'limit': '8',
      if (acceptLanguage != null && acceptLanguage.isNotEmpty) 'accept-language': acceptLanguage,
    });
    final resp = await http.get(uri, headers: {'User-Agent': _userAgent});
    if (resp.statusCode != 200) {
      throw GeocodeException('Geocoding request failed (${resp.statusCode})');
    }
    final results = jsonDecode(resp.body) as List<dynamic>;

    return results.map((r) {
      final result = r as Map<String, dynamic>;
      final lat = double.parse(result['lat'] as String);
      final lng = double.parse(result['lon'] as String);
      final address = result['address'] as Map<String, dynamic>? ?? {};
      final namedetails = result['namedetails'] as Map<String, dynamic>? ?? {};
      final displayName = result['display_name'] as String? ?? query;
      final name = (result['name'] as String?)?.isNotEmpty == true
          ? result['name'] as String
          : displayName.split(',').first.trim();
      final countryCode = (address['country_code'] as String?)?.toUpperCase();
      final nativeName = namedetails['name'] as String?;
      final localName = (nativeName != null && nativeName.isNotEmpty && nativeName != name) ? nativeName : null;

      return LocationSearchCandidate(
        locationId: CacheService.normalizeLocationId(lat, lng),
        name: name,
        formattedAddress: displayName,
        lat: lat,
        lng: lng,
        countryCode: countryCode,
        localName: localName,
      );
    }).toList();
  }
}
