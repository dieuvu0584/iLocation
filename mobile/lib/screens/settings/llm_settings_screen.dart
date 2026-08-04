import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../models/settings_models.dart';
import '../../services/api_client.dart';
import '../../state/app_settings.dart';
import '../../theme/colors.dart';
import '../../widgets/common/settings_scaffold.dart';

/// SDD §7.2 / CLAUDE.md principle #5: the BYOK key is only ever read from
/// secure storage right before a request and written here on Save — it is
/// never sent anywhere except the single LLM call it authorizes.
class LlmSettingsScreen extends StatefulWidget {
  const LlmSettingsScreen({super.key});

  @override
  State<LlmSettingsScreen> createState() => _LlmSettingsScreenState();
}

class _LlmSettingsScreenState extends State<LlmSettingsScreen> {
  final _apiKeyController = TextEditingController();
  bool _apiKeyLoaded = false;
  Map<String, dynamic>? _usage;
  String? _usageError;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _loadUsage();
  }

  Future<void> _loadApiKey() async {
    final key = await context.read<AppSettings>().getByokApiKey();
    if (!mounted) return;
    setState(() {
      _apiKeyController.text = key ?? '';
      _apiKeyLoaded = true;
    });
  }

  Future<void> _loadUsage() async {
    try {
      final appSettings = context.read<AppSettings>();
      final usage = await context.read<ApiClient>().getLlmUsage(appSettings.deviceId);
      if (!mounted) return;
      setState(() => _usage = usage);
    } catch (e) {
      if (!mounted) return;
      setState(() => _usageError = e.toString());
    }
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
            SettingsSectionLabel(l10n.providerMode),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RadioGroup<ProviderMode>(
                groupValue: appSettings.providerMode,
                onChanged: (v) => appSettings.setProviderMode(v!),
                child: Column(
                  children: [
                    RadioListTile<ProviderMode>(
                      value: ProviderMode.free,
                      title: Text(l10n.providerFree),
                      activeColor: AppColors.accentAmber,
                    ),
                    RadioListTile<ProviderMode>(
                      value: ProviderMode.byok,
                      title: Text(l10n.providerByok),
                      activeColor: AppColors.accentAmber,
                    ),
                  ],
                ),
              ),
            ),
            if (appSettings.providerMode == ProviderMode.free) _FreeTierUsage(usage: _usage, error: _usageError, l10n: l10n),
            if (appSettings.providerMode == ProviderMode.byok) ...[
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
                      value: appSettings.byokProvider,
                      isExpanded: true,
                      dropdownColor: AppColors.cardBg1,
                      items: ByokProvider.values
                          .map((p) => DropdownMenuItem(value: p, child: Text(_providerName(p))))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) appSettings.setByokProvider(v);
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
                        await appSettings.setByokApiKey(_apiKeyController.text.trim());
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.save)));
                        }
                      },
                    ),
                  ),
                ),
              ),
              SwitchListTile(
                value: appSettings.fallbackEnabled,
                onChanged: appSettings.setFallbackEnabled,
                title: Text(l10n.fallbackEnabled),
                subtitle: Text(l10n.fallbackEnabledDesc, style: const TextStyle(color: AppColors.textMuted)),
              ),
            ],
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

class _FreeTierUsage extends StatelessWidget {
  final Map<String, dynamic>? usage;
  final String? error;
  final AppLocalizations l10n;

  const _FreeTierUsage({required this.usage, required this.error, required this.l10n});

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(error!, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      );
    }
    if (usage == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: LinearProgressIndicator(color: AppColors.accentAmber, backgroundColor: AppColors.cardBg1),
      );
    }
    final used = usage!['usage_today'] as int? ?? 0;
    final limit = usage!['limit'] as int? ?? 1;
    final ratio = limit == 0 ? 0.0 : (used / limit).clamp(0.0, 1.0);
    final isNearLimit = ratio >= 0.8;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              color: isNearLimit ? AppColors.error : AppColors.accentAmber,
              backgroundColor: AppColors.cardBg1,
            ),
          ),
          const SizedBox(height: 8),
          Text(l10n.freeTierUsage(used, limit), style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          if (isNearLimit) ...[
            const SizedBox(height: 4),
            Text(l10n.freeTierWarning, style: const TextStyle(color: AppColors.error, fontSize: 12)),
          ],
        ],
      ),
    );
  }
}
