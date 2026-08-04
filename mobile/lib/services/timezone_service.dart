import '../models/location_models.dart';

/// Offline, no-key timezone estimate from longitude (CLAUDE.md "Quyết định
/// đã chốt 2026-08-04 (đợt 2)"): `timezonefinder` was Python-only, so on a
/// client-only app this is a deliberate accuracy tradeoff — 1 hour per 15°
/// of longitude, no DST, no real IANA zone name. Good enough for "roughly
/// what time is it there," not for anything precise.
class TimezoneService {
  ChildItem getTimezoneItem(double lat, double lng) {
    final offsetHours = (lng / 15).round().clamp(-12, 14);
    final sign = offsetHours >= 0 ? '+' : '-';
    final offsetLabel = 'UTC$sign${offsetHours.abs().toString().padLeft(2, '0')}:00';

    return ChildItem(
      id: 'timezone',
      label: kChildLabels['timezone']!,
      source: 'static',
      summary: 'Approx. $offsetLabel',
      detail: 'Estimated from longitude only — not DST-aware and may be off by an hour '
          'near timezone boundaries. For exact local time, check a dedicated timezone service.',
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
