import '../models/location_models.dart';

/// Builds a deterministic "view signature photos" link for a location —
/// no network call, no API key, nothing that can go stale, so it's grouped
/// with the other on-device static items (CLAUDE.md: every provider that
/// needs a key is BYOK; this needs none). The detail panel opens the URL in
/// the external browser via `url_launcher` instead of showing summary text.
class PhotoLinkService {
  ChildItem getPhotosItem(String locationName, String? country) {
    final query = [locationName, country].where((s) => s != null && s.isNotEmpty).join(' ');
    final url = 'https://www.google.com/search?tbm=isch&q=${Uri.encodeComponent(query)}';

    return ChildItem(
      id: 'photos',
      label: kChildLabels['photos']!,
      source: 'link',
      summary: 'View iconic photos of $locationName',
      detail: '',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
      linkUrl: url,
    );
  }
}
