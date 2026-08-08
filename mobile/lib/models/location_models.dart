/// Mirrors backend/app/models/location.py — see SDD §4 for the schema.
library;

/// Fixed group ids — do not add/remove without updating the SDD.
const List<String> kGroupIds = ['explore', 'practical', 'safety', 'culture', 'entry_stay'];

const Map<String, List<String>> kChildIdsByGroup = {
  'explore': ['places', 'food', 'best_time', 'travel_tips', 'hotels', 'photos', 'maps', 'directions'],
  'practical': ['weather', 'transport', 'power', 'currency', 'timezone'],
  'safety': ['safety_level', 'safety_history', 'health', 'water', 'insurance', 'emergency'],
  'culture': ['language', 'etiquette', 'tipping', 'holidays', 'history'],
  'entry_stay': ['visa', 'airport', 'stay', 'cost'],
};

/// Items backed directly by a structured API call — never sent through the LLM.
const Set<String> kApiItemIds = {'places', 'weather', 'airport', 'hotels'};

/// Items computed/looked up on-device, no network call, never sent to the LLM.
const Set<String> kStaticItemIds = {'emergency', 'timezone', 'photos', 'maps', 'directions'};

/// Everything else is LLM-summarized from web search results.
const Set<String> kLlmItemIds = {
  'food', 'best_time', 'travel_tips', 'transport', 'power', 'currency', 'safety_level', 'safety_history', 'health',
  'water', 'insurance', 'language', 'etiquette', 'tipping', 'holidays', 'history', 'visa', 'stay', 'cost',
};

/// Group/child labels — kept as fixed English strings (not run through
/// `AppLocalizations`), matching how the original backend always returned
/// them regardless of content language; only the LLM-summarized text itself
/// is localized (SDD §7.1: UI language vs content language are separate).
const Map<String, String> kGroupLabels = {
  'explore': 'Explore',
  'practical': 'Practical',
  'safety': 'Safety & Health',
  'culture': 'Culture',
  'entry_stay': 'Entry & Stay',
};

const Map<String, String> kChildLabels = {
  'places': 'Nearby places',
  'food': 'Local food',
  'best_time': 'Best time to visit',
  'travel_tips': 'Travel tips',
  'weather': 'Weather',
  'transport': 'Getting around',
  'power': 'Power & SIM',
  'currency': 'Currency & payments',
  'timezone': 'Timezone',
  'safety_level': 'Safety',
  'safety_history': 'Safety history',
  'health': 'Healthcare',
  'water': 'Drinking water',
  'insurance': 'Travel insurance',
  'emergency': 'Emergency numbers',
  'language': 'Language',
  'etiquette': 'Etiquette',
  'tipping': 'Tipping culture',
  'holidays': 'Local holidays',
  'history': 'History',
  'visa': 'Visa',
  'airport': 'Nearest airport',
  'stay': 'Where to stay',
  'cost': 'Cost of living',
  'hotels': 'Hotels',
  'photos': 'Signature photos',
  'maps': 'Google Maps',
  'directions': 'Get there',
};

class LocationInfo {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String? countryCode;

  /// Full country name (e.g. "United States"), from Nominatim's
  /// `address.country` — already localized to whatever `accept-language`
  /// the search request used. Shown as the smaller sub-label under the
  /// location name on the node-graph center node.
  final String? country;

  const LocationInfo({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.countryCode,
    this.country,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
        id: json['id'] as String,
        name: json['name'] as String,
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        countryCode: json['country_code'] as String?,
        country: json['country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lat': lat,
        'lng': lng,
        'country_code': countryCode,
        'country': country,
      };
}

class LocationSearchCandidate {
  final String locationId;
  final String name;
  final String formattedAddress;
  final double lat;
  final double lng;
  final String? countryCode;

  /// The place's native/local-language name from OpenStreetMap
  /// (`namedetails.name`), only set when it differs from [name] — i.e. when
  /// [name] came back translated into the requested `accept-language`. Null
  /// when there's nothing distinct to show (see `geocode_service.dart`).
  final String? localName;

  /// Full country name from Nominatim's `address.country` — see
  /// `LocationInfo.country`.
  final String? country;

  const LocationSearchCandidate({
    required this.locationId,
    required this.name,
    required this.formattedAddress,
    required this.lat,
    required this.lng,
    this.countryCode,
    this.localName,
    this.country,
  });

  factory LocationSearchCandidate.fromJson(Map<String, dynamic> json) => LocationSearchCandidate(
        locationId: json['location_id'] as String,
        name: json['name'] as String,
        formattedAddress: json['formatted_address'] as String,
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        countryCode: json['country_code'] as String?,
        localName: json['local_name'] as String?,
        country: json['country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'location_id': locationId,
        'name': name,
        'formatted_address': formattedAddress,
        'lat': lat,
        'lng': lng,
        'country_code': countryCode,
        'local_name': localName,
        'country': country,
      };
}

/// `source`: api = structured API, llm = AI-summarized, static = reference
/// table, search = raw search results (LLM disabled), link = external
/// link-out item (e.g. "photos" — no in-app content, just an outbound URL).
class ChildItem {
  final String id;
  final String label;
  final String source;
  final String summary;
  final String detail;
  final List<String> sources;
  final DateTime updatedAt;
  final bool isStale;
  final String? warning;

  /// Set only for `source == 'link'` items — the URL the detail panel's
  /// "Open" button launches via `url_launcher` instead of showing
  /// summary/detail text as the main content.
  final String? linkUrl;

  const ChildItem({
    required this.id,
    required this.label,
    required this.source,
    required this.summary,
    required this.detail,
    required this.sources,
    required this.updatedAt,
    this.isStale = false,
    this.warning,
    this.linkUrl,
  });

  factory ChildItem.fromJson(Map<String, dynamic> json) => ChildItem(
        id: json['id'] as String,
        label: json['label'] as String,
        source: json['source'] as String,
        summary: json['summary'] as String,
        detail: json['detail'] as String? ?? '',
        sources: (json['sources'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        isStale: json['is_stale'] as bool? ?? false,
        warning: json['warning'] as String?,
        linkUrl: json['link_url'] as String?,
      );
}

class Group {
  final String id;
  final String label;
  final List<ChildItem> children;

  const Group({required this.id, required this.label, required this.children});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'] as String,
        label: json['label'] as String,
        children: (json['children'] as List<dynamic>)
            .map((e) => ChildItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class LocationResponse {
  final LocationInfo location;
  final DateTime cachedAt;
  final List<Group> groups;

  const LocationResponse({required this.location, required this.cachedAt, required this.groups});

  factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
        location: LocationInfo.fromJson(json['location'] as Map<String, dynamic>),
        cachedAt: DateTime.parse(json['cached_at'] as String),
        groups: (json['groups'] as List<dynamic>).map((e) => Group.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Group? groupById(String id) {
    for (final g in groups) {
      if (g.id == id) return g;
    }
    return null;
  }
}
