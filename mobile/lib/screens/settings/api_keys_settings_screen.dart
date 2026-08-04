import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../state/app_settings.dart';
import '../../theme/colors.dart';
import '../../widgets/common/settings_scaffold.dart';

/// Weather and Search are BYOK — there's no backend to hold a shared key
/// (CLAUDE.md "Quyết định đã chốt 2026-08-04 (đợt 2)"). Places/Geocoding
/// isn't here anymore: it runs on OpenStreetMap and needs no key at all
/// (đợt 3). Keys are written straight to flutter_secure_storage and never
/// leave the device except in a request to the provider that issued them.
class ApiKeysSettingsScreen extends StatefulWidget {
  const ApiKeysSettingsScreen({super.key});

  @override
  State<ApiKeysSettingsScreen> createState() => _ApiKeysSettingsScreenState();
}

class _ApiKeysSettingsScreenState extends State<ApiKeysSettingsScreen> {
  final _weatherController = TextEditingController();
  final _searchController = TextEditingController();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final appSettings = context.read<AppSettings>();
    String? weather, search;
    try {
      weather = await appSettings.getWeatherApiKey();
      search = await appSettings.getSearchApiKey();
    } catch (_) {
      // Leave fields blank/editable rather than stuck disabled forever.
    }
    if (!mounted) return;
    setState(() {
      _weatherController.text = weather ?? '';
      _searchController.text = search ?? '';
      _loaded = true;
    });
  }

  @override
  void dispose() {
    _weatherController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _save(Future<void> Function(String) setter, String value) async {
    await setter(value.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.save)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appSettings = context.read<AppSettings>();

    return SettingsScaffold(
      title: l10n.apiKeysTitle,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBg1,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Text(l10n.placesNoKeyNote, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ),
          ),
          _ApiKeyField(
            label: l10n.weatherApiKeyLabel,
            description: l10n.weatherApiKeyDesc,
            controller: _weatherController,
            enabled: _loaded,
            onSave: (v) => _save(appSettings.setWeatherApiKey, v),
          ),
          _ApiKeyField(
            label: l10n.searchApiKeyLabel,
            description: l10n.searchApiKeyDesc,
            controller: _searchController,
            enabled: _loaded,
            onSave: (v) => _save(appSettings.setSearchApiKey, v),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ApiKeyField extends StatelessWidget {
  final String label;
  final String description;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onSave;

  const _ApiKeyField({
    required this.label,
    required this.description,
    required this.controller,
    required this.enabled,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionLabel(label),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
          child: Text(description, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controller,
            obscureText: true,
            enabled: enabled,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.save_outlined, color: AppColors.accentAmber),
                onPressed: () => onSave(controller.text),
              ),
            ),
            onSubmitted: onSave,
          ),
        ),
      ],
    );
  }
}
