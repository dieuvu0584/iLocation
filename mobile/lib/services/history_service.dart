import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/location_models.dart';

class HistoryEntry {
  final LocationSearchCandidate candidate;
  final DateTime viewedAt;

  const HistoryEntry({required this.candidate, required this.viewedAt});

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
        candidate: LocationSearchCandidate.fromJson(json['candidate'] as Map<String, dynamic>),
        viewedAt: DateTime.parse(json['viewed_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'candidate': candidate.toJson(),
        'viewed_at': viewedAt.toIso8601String(),
      };
}

/// Local-only search history (SDD §7.3). Not sensitive, so plain
/// SharedPreferences rather than secure storage.
class HistoryService {
  static const _kHistory = 'location_history';
  static const _maxEntries = 50;

  final SharedPreferences _prefs;

  HistoryService(this._prefs);

  static Future<HistoryService> create() async => HistoryService(await SharedPreferences.getInstance());

  List<HistoryEntry> getAll() {
    final raw = _prefs.getString(_kHistory);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> add(LocationSearchCandidate candidate) async {
    final entries = getAll().where((e) => e.candidate.locationId != candidate.locationId).toList();
    entries.insert(0, HistoryEntry(candidate: candidate, viewedAt: DateTime.now()));
    final trimmed = entries.take(_maxEntries).toList();
    await _prefs.setString(_kHistory, jsonEncode(trimmed.map((e) => e.toJson()).toList()));
  }

  Future<void> remove(String locationId) async {
    final entries = getAll().where((e) => e.candidate.locationId != locationId).toList();
    await _prefs.setString(_kHistory, jsonEncode(entries.map((e) => e.toJson()).toList()));
  }

  Future<void> clear() async {
    await _prefs.remove(_kHistory);
  }
}
