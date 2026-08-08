import '../models/location_models.dart';

/// Builds a deterministic "open in Google Maps" link for a location — no
/// network call, no API key, nothing that can go stale, so it's grouped
/// with the other on-device static items (same pattern as
/// `photo_link_service.dart`). Uses lat/lng (Google's documented Maps URL
/// API) rather than a name-based query, so it always pins the exact spot
/// regardless of how many places share that name.
class MapLinkService {
  ChildItem getMapsItem(double lat, double lng, String locationName) {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    return ChildItem(
      id: 'maps',
      label: kChildLabels['maps']!,
      source: 'link',
      summary: 'Open $locationName in Google Maps',
      detail: '',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
      linkUrl: url,
    );
  }

  /// "How do I get there" — a Google Maps directions link with only the
  /// destination set. Deliberately omits an origin: Google Maps resolves
  /// "your location" itself once the link opens on the phone, so this needs
  /// no on-device geolocation permission/plugin at all, matching this app's
  /// no-key/static-link pattern.
  ChildItem getDirectionsItem(double lat, double lng, String locationName) {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';

    return ChildItem(
      id: 'directions',
      label: kChildLabels['directions']!,
      source: 'link',
      summary: 'Get directions to $locationName from your current location',
      detail: '',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
      linkUrl: url,
    );
  }
}
