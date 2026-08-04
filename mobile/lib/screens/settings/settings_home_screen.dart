import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/colors.dart';
import '../../widgets/common/settings_scaffold.dart';
import 'api_keys_settings_screen.dart';
import 'language_settings_screen.dart';
import 'llm_settings_screen.dart';
import 'privacy_settings_screen.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SettingsScaffold(
      title: l10n.settingsTitle,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _SettingsTile(
            icon: Icons.translate_outlined,
            title: l10n.settingsLanguageUnits,
            subtitle: l10n.settingsLanguageUnitsDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LanguageSettingsScreen())),
          ),
          _SettingsTile(
            icon: Icons.vpn_key_outlined,
            title: l10n.settingsApiKeys,
            subtitle: l10n.settingsApiKeysDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ApiKeysSettingsScreen())),
          ),
          _SettingsTile(
            icon: Icons.auto_awesome_outlined,
            title: l10n.settingsAiAssistant,
            subtitle: l10n.settingsAiAssistantDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LlmSettingsScreen())),
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: l10n.settingsDataPrivacy,
            subtitle: l10n.settingsDataPrivacyDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrivacySettingsScreen())),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        child: ListTile(
          leading: Icon(icon, color: AppColors.accentAmber),
          title: Text(title),
          subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textMuted)),
          trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
          onTap: onTap,
        ),
      ),
    );
  }
}
