import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../db/app_database.dart';
import '../models/location_models.dart';

/// Dart port of the original backend's `app/services/cache.py` — cache-first
/// reads, per-item TTL, all on-device now (see CLAUDE.md "Quyết định đã
/// chốt 2026-08-04 (đợt 2)"). Do not collapse this to a single TTL for
/// everything; different item types tolerate different staleness (SDD §5).
class CacheService {
  /// TTL per item_id. `null` means "no TTL" (static data, e.g. emergency).
  static const Map<String, Duration?> ttlByItem = {
    // Weather: 3 hours
    'weather': Duration(hours: 3),
    // Nearby places / airport / hotels: 30 days
    'places': Duration(days: 30),
    'airport': Duration(days: 30),
    'hotels': Duration(days: 30),
    // Rarely-changing content: 90 days
    'food': Duration(days: 90),
    'best_time': Duration(days: 90),
    'travel_tips': Duration(days: 90),
    'language': Duration(days: 90),
    'etiquette': Duration(days: 90),
    'tipping': Duration(days: 90),
    'holidays': Duration(days: 90),
    'history': Duration(days: 90),
    'safety_history': Duration(days: 90),
    'timezone': Duration(days: 90),
    // Needs-to-be-fresher content: 14 days
    'transport': Duration(days: 14),
    'power': Duration(days: 14),
    'currency': Duration(days: 14),
    'safety_level': Duration(days: 14),
    'health': Duration(days: 14),
    'water': Duration(days: 14),
    'insurance': Duration(days: 14),
    'visa': Duration(days: 14),
    'stay': Duration(days: 14),
    'cost': Duration(days: 14),
    // Static lookup table / deterministic link, never expires via TTL
    'emergency': null,
    'photos': null,
    'maps': null,
    'directions': null,
  };

  static const Duration _defaultTtl = Duration(days: 14);
  static const int _locationIdPrecision = 3;

  /// Rounds lat/lng so nearby repeat lookups collapse into the same cache
  /// entry (SDD §5).
  static String normalizeLocationId(double lat, double lng) {
    final roundedLat = double.parse(lat.toStringAsFixed(_locationIdPrecision));
    final roundedLng = double.parse(lng.toStringAsFixed(_locationIdPrecision));
    return '${roundedLat.toStringAsFixed(_locationIdPrecision)}_${roundedLng.toStringAsFixed(_locationIdPrecision)}';
  }

  DateTime? _expiresAt(String itemId, DateTime now) {
    final hasKey = ttlByItem.containsKey(itemId);
    final ttl = hasKey ? ttlByItem[itemId] : _defaultTtl;
    if (ttl == null) return null;
    return now.add(ttl);
  }

  Future<void> upsertLocation(LocationInfo location) async {
    final db = await AppDatabase.instance;
    await db.insert(
      'locations',
      {
        'location_id': location.id,
        'name': location.name,
        'lat': location.lat,
        'lng': location.lng,
        'country_code': location.countryCode,
        'country': location.country,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<LocationInfo?> getLocation(String locationId) async {
    final db = await AppDatabase.instance;
    final rows = await db.query('locations', where: 'location_id = ?', whereArgs: [locationId]);
    if (rows.isEmpty) return null;
    final row = rows.first;
    return LocationInfo(
      id: row['location_id'] as String,
      name: row['name'] as String,
      lat: row['lat'] as double,
      lng: row['lng'] as double,
      countryCode: row['country_code'] as String?,
      country: row['country'] as String?,
    );
  }

  Future<void> putItem(String locationId, String groupId, ChildItem item) async {
    final db = await AppDatabase.instance;
    final now = DateTime.now().toUtc();
    await db.insert(
      'cache_items',
      {
        'location_id': locationId,
        'item_id': item.id,
        'group_id': groupId,
        'label': item.label,
        'source': item.source,
        'summary': item.summary,
        'detail': item.detail,
        'sources_json': jsonEncode(item.sources),
        'warning': item.warning,
        'updated_at': item.updatedAt.toIso8601String(),
        'expires_at': _expiresAt(item.id, now)?.toIso8601String(),
        'link_url': item.linkUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ChildItem _rowToItem(Map<String, Object?> row, {bool isStale = false}) {
    return ChildItem(
      id: row['item_id'] as String,
      label: row['label'] as String,
      source: row['source'] as String,
      summary: row['summary'] as String,
      detail: row['detail'] as String? ?? '',
      sources: (jsonDecode(row['sources_json'] as String? ?? '[]') as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      warning: row['warning'] as String?,
      updatedAt: DateTime.parse(row['updated_at'] as String),
      isStale: isStale,
      linkUrl: row['link_url'] as String?,
    );
  }

  /// Returns a cached item only if present and not expired. A `missing_key`
  /// placeholder is never treated as fresh — the user may add the API key
  /// at any time after it was cached, so it must always be retried instead
  /// of sticking around for the item's full TTL (14-90 days).
  Future<ChildItem?> getItem(String locationId, String itemId) async {
    final db = await AppDatabase.instance;
    final rows = await db.query(
      'cache_items',
      where: 'location_id = ? AND item_id = ?',
      whereArgs: [locationId, itemId],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    if (row['source'] == 'missing_key') return null;
    final expiresAt = row['expires_at'] as String?;
    if (expiresAt != null && DateTime.now().toUtc().isAfter(DateTime.parse(expiresAt))) {
      return null;
    }
    return _rowToItem(row);
  }

  /// Used as a fallback when a live refetch fails — better a stale value
  /// than none.
  Future<ChildItem?> getItemEvenIfStale(String locationId, String itemId) async {
    final db = await AppDatabase.instance;
    final rows = await db.query(
      'cache_items',
      where: 'location_id = ? AND item_id = ?',
      whereArgs: [locationId, itemId],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    final expiresAt = row['expires_at'] as String?;
    final isStale = expiresAt != null && DateTime.now().toUtc().isAfter(DateTime.parse(expiresAt));
    return _rowToItem(row, isStale: isStale);
  }

  /// Assembles a LocationResponse from whatever is currently cached (may be
  /// partial).
  Future<LocationResponse?> getFullLocation(String locationId) async {
    final location = await getLocation(locationId);
    if (location == null) return null;

    final groups = <Group>[];
    var latestUpdatedAt = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    for (final entry in kChildIdsByGroup.entries) {
      final children = <ChildItem>[];
      for (final itemId in entry.value) {
        final item = await getItem(locationId, itemId);
        if (item != null) {
          children.add(item);
          if (item.updatedAt.isAfter(latestUpdatedAt)) latestUpdatedAt = item.updatedAt;
        }
      }
      if (children.isNotEmpty) {
        groups.add(Group(id: entry.key, label: kGroupLabels[entry.key]!, children: children));
      }
    }

    if (groups.isEmpty) return null;
    return LocationResponse(location: location, cachedAt: latestUpdatedAt, groups: groups);
  }

  Future<void> deleteLocation(String locationId) async {
    final db = await AppDatabase.instance;
    await db.delete('cache_items', where: 'location_id = ?', whereArgs: [locationId]);
    await db.delete('locations', where: 'location_id = ?', whereArgs: [locationId]);
  }

  Future<Map<String, dynamic>> cacheStats() async {
    final db = await AppDatabase.instance;
    final locations = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM locations')) ?? 0;
    final items = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM cache_items')) ?? 0;
    return {'locations': locations, 'items': items};
  }

  Future<void> clearAllCache() async {
    final db = await AppDatabase.instance;
    await db.delete('cache_items');
    await db.delete('locations');
  }
}
