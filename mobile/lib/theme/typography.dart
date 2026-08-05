import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Display = Fraunces (serif), Body = Inter (sans) — SDD §9.
class AppTypography {
  AppTypography._();

  /// Concrete Material 3 font sizes, used as the base `GoogleFonts.x
  /// TextTheme()` calls apply their font family on top of. This is
  /// deliberately NOT derived from `ThemeData(...).textTheme` or
  /// `Typography.material2021(...).white` — both were verified (2026-08-05)
  /// to come back with every `fontSize` null outside of a fully resolved
  /// widget tree, which silently broke the font-size setting: `.apply
  /// (fontSizeFactor:)` had nothing to multiply, so every Text fell back to
  /// Flutter's own built-in default size regardless of the user's choice.
  static const _fallbackSizes = TextTheme(
    displayLarge: TextStyle(fontSize: 57),
    displayMedium: TextStyle(fontSize: 45),
    displaySmall: TextStyle(fontSize: 36),
    headlineLarge: TextStyle(fontSize: 32),
    headlineMedium: TextStyle(fontSize: 28),
    headlineSmall: TextStyle(fontSize: 24),
    titleLarge: TextStyle(fontSize: 22),
    titleMedium: TextStyle(fontSize: 16),
    titleSmall: TextStyle(fontSize: 14),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
    labelLarge: TextStyle(fontSize: 14),
    labelMedium: TextStyle(fontSize: 12),
    labelSmall: TextStyle(fontSize: 11),
  );

  static TextTheme textTheme(double fontScale) {
    final base = GoogleFonts.interTextTheme(_fallbackSizes);
    final display = GoogleFonts.frauncesTextTheme(_fallbackSizes);

    return base
        .copyWith(
          displayLarge: display.displayLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          displayMedium: display.displayMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          displaySmall: display.displaySmall?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          headlineLarge: display.headlineLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          headlineMedium: display.headlineMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          headlineSmall: display.headlineSmall?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleLarge: base.titleLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleMedium: base.titleMedium?.copyWith(color: AppColors.textPrimary),
          titleSmall: base.titleSmall?.copyWith(color: AppColors.textSecondary),
          bodyLarge: base.bodyLarge?.copyWith(color: AppColors.textPrimary),
          bodyMedium: base.bodyMedium?.copyWith(color: AppColors.textPrimary),
          bodySmall: base.bodySmall?.copyWith(color: AppColors.textMuted),
          labelLarge: base.labelLarge?.copyWith(color: AppColors.textPrimary),
          labelMedium: base.labelMedium?.copyWith(color: AppColors.textSecondary),
          labelSmall: base.labelSmall?.copyWith(color: AppColors.textMuted),
        )
        .apply(fontSizeFactor: fontScale);
  }
}
