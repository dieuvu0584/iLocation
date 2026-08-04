import 'package:flutter/material.dart';

/// Palette locked in across many design rounds — see SDD §9 and CLAUDE.md.
/// Do not change without checking with the project owner.
class AppColors {
  AppColors._();

  static const bgDark = Color(0xFF0A141D);
  static const bgMid = Color(0xFF16283A);
  static const accentAmber = Color(0xFFE8A33D);
  static const accentAmberDark = Color(0xFFC97C2E);
  static const cardBg1 = Color(0xFF1B2E3D);
  static const cardBg2 = Color(0xFF142330);
  static const textPrimary = Color(0xFFEDEAE3);
  static const textSecondary = Color(0xFF7FA8C9);
  static const textMuted = Color(0xFF9FB6C6);
  static const borderColor = Color(0xFF2A4356);

  static const error = Color(0xFFE0704F);
  static const success = Color(0xFF6FBF8C);

  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgDark, bgMid],
  );
}
