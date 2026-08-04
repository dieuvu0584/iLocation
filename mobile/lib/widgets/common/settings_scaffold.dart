import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// Shared page chrome for every settings screen: gradient background + a
/// simple back-arrow app bar, consistent with the rest of the app.
class SettingsScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                    Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSectionLabel extends StatelessWidget {
  final String text;
  const SettingsSectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(letterSpacing: 0.5),
      ),
    );
  }
}
