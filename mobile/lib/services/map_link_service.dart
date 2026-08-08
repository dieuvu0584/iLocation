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
}
