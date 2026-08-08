import 'package:flutter/material.dart';

/// Material Icons stand in for the lucide-style icon set referenced in the
/// SDD prototype (`flutter_lucide`/`lucide_icons` weren't pinned to a
/// verified version in this environment — swap in easily later, the mapping
/// is centralized here).
const Map<String, IconData> kGroupIcons = {
  'explore': Icons.explore_outlined,
  'practical': Icons.checklist_outlined,
  'safety': Icons.health_and_safety_outlined,
  'culture': Icons.theater_comedy_outlined,
  'entry_stay': Icons.flight_land_outlined,
};

const Map<String, IconData> kChildIcons = {
  'places': Icons.place_outlined,
  'food': Icons.restaurant_outlined,
  'best_time': Icons.calendar_month_outlined,
  'weather': Icons.wb_cloudy_outlined,
  'transport': Icons.directions_bus_outlined,
  'power': Icons.power_outlined,
  'currency': Icons.attach_money_outlined,
  'timezone': Icons.schedule_outlined,
  'safety_level': Icons.shield_outlined,
  'health': Icons.local_hospital_outlined,
  'water': Icons.water_drop_outlined,
  'insurance': Icons.verified_user_outlined,
  'emergency': Icons.emergency_outlined,
  'language': Icons.translate_outlined,
  'etiquette': Icons.handshake_outlined,
  'tipping': Icons.payments_outlined,
  'holidays': Icons.celebration_outlined,
  'visa': Icons.badge_outlined,
  'airport': Icons.flight_outlined,
  'stay': Icons.hotel_outlined,
  'cost': Icons.savings_outlined,
  'hotels': Icons.bed_outlined,
  'photos': Icons.photo_library_outlined,
  'maps': Icons.map_outlined,
};

IconData iconForGroup(String groupId) => kGroupIcons[groupId] ?? Icons.circle_outlined;

IconData iconForChild(String childId) => kChildIcons[childId] ?? Icons.circle_outlined;
