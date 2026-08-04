import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../models/settings_models.dart';
import '../../state/app_settings.dart';
import '../../theme/colors.dart';
import '../../widgets/common/settings_scaffold.dart';

/// Every provider is BYOK now (CLAUDE.md "Quyết định đã chốt 2026-08-04
/// (đợt 2)") — no more free tier/fallback, since there's no backend to hold
/// a shared key or enforce a shared rate limit. The key is only ever read
/// from secure storage right before a request and written here on Save.
class LlmSettingsScreen extends StatefulWidget {
  const LlmSettingsScreen({super.key});

  @override
  State<LlmSettingsScreen> createState() => _LlmSettingsScreenState();
}

class _LlmSettingsScreenState extends State<LlmSettingsScreen> {
  final _apiKeyController = TextEditingController();
  bool _apiKeyLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    String? key;
    try {
      key = await context.read<AppSettings>().getLlmApiKey();
    } catch (_) {
      // Leave the field blank/editable rather than stuck disabled forever.
    }
    if (!mounted) return;
    setState(() {
      _apiKeyController.text = key ?? '';
      _apiKeyLoaded = true;
    });
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appSettings = context.watch<AppSettings>();

    return SettingsScaffold(
      title: l10n.llmSettingsTitle,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          SwitchListTile(
            value: appSettings.llmEnabled,
            onChanged: appSettings.setLlmEnabled,
            title: Text(l10n.llmEnabled),
            subtitle: Text(l10n.llmEnabledDesc, style: const TextStyle(color: AppColors.textMuted)),
          ),
          if (appSettings.llmEnabled) ...[
            SettingsSectionLabel(l10n.byokProviderLabel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.cardBg2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ByokProvider>(
                    value: appSettings.llmProvider,
                    isExpanded: true,
                    dropdownColor: AppColors.cardBg1,
                    items: ByokProvider.values
                        .map((p) => DropdownMenuItem(value: p, child: Text(_providerName(p))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) appSettings.setLlmProvider(v);
                    },
                  ),
                ),
              ),
            ),
            SettingsSectionLabel(l10n.byokApiKey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _apiKeyController,
                obscureText: true,
                enabled: _apiKeyLoaded,
                decoration: InputDecoration(
                  hintText: l10n.byokApiKeyHint,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.save_outlined, color: AppColors.accentAmber),
                    onPressed: () async {
                      await appSettings.setLlmApiKey(_apiKeyController.text.trim());
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.save)));
                      }
                    },
                  ),
                ),
              ),
            ),
            SettingsSectionLabel(l10n.detailLevel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SegmentedButton<DetailLevel>(
                segments: [
                  ButtonSegment(value: DetailLevel.short, label: Text(l10n.detailLevelShort)),
                  ButtonSegment(value: DetailLevel.detailed, label: Text(l10n.detailLevelDetailed)),
                ],
                selected: {appSettings.detailLevel},
                onSelectionChanged: (s) => appSettings.setDetailLevel(s.first),
              ),
            ),
            SwitchListTile(
              value: appSettings.showSources,
              onChanged: appSettings.setShowSources,
              title: Text(l10n.showSources),
              subtitle: Text(l10n.showSourcesDesc, style: const TextStyle(color: AppColors.textMuted)),
            ),
          ],
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBg1,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Text(l10n.llmDisclaimer, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _providerName(ByokProvider p) {
    switch (p) {
      case ByokProvider.gemini:
        return 'Gemini';
      case ByokProvider.groq:
        return 'Groq';
      case ByokProvider.openrouter:
        return 'OpenRouter';
      case ByokProvider.openai:
        return 'OpenAI';
    }
  }
}
