import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Display = Fraunces (serif), Body = Inter (sans) — SDD §9.
class AppTypography {
  AppTypography._();

  static TextTheme textTheme(double fontScale) {
    final base = GoogleFonts.interTextTheme();
    final display = GoogleFonts.frauncesTextTheme();

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
