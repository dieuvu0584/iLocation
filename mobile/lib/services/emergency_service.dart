import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/location_models.dart';

/// Static per-country emergency-number lookup, bundled as an app asset
/// (`assets/emergency_numbers.json`, same data the original backend used).
/// Never LLM-generated — see SDD §8: this is accuracy-critical data.
class EmergencyService {
  Map<String, dynamic>? _table;

  Future<Map<String, dynamic>> _loadTable() async {
    if (_table != null) return _table!;
    final raw = await rootBundle.loadString('assets/emergency_numbers.json');
    _table = jsonDecode(raw) as Map<String, dynamic>;
    return _table!;
  }

  Future<ChildItem> getEmergencyItem(String? countryCode) async {
    final table = await _loadTable();
    final key = (countryCode ?? '').toUpperCase();
    final isFallback = !table.containsKey(key);
    final entry = (isFallback ? table['_default'] : table[key]) as Map<String, dynamic>;

    final numbers = 'Police: ${entry['police']} · Ambulance: ${entry['ambulance']} · Fire: ${entry['fire']}';
    final summary = 'General emergency: ${entry['general']}';

    return ChildItem(
      id: 'emergency',
      label: kChildLabels['emergency']!,
      source: 'static',
      summary: summary,
      detail: numbers,
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
      warning: isFallback ? entry['note'] as String? : null,
    );
  }
}
