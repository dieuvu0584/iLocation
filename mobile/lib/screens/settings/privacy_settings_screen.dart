import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../services/cache_service.dart';
import '../../services/history_service.dart';
import '../../state/app_settings.dart';
import '../../theme/colors.dart';
import '../../widgets/common/settings_scaffold.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  Map<String, dynamic>? _cacheStats;
  String? _cacheError;
  int _historyCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCacheStats();
    _loadHistoryCount();
  }

  Future<void> _loadCacheStats() async {
    try {
      final stats = await context.read<CacheService>().cacheStats();
      if (!mounted) return;
      setState(() => _cacheStats = stats);
    } catch (e) {
      if (!mounted) return;
      setState(() => _cacheError = e.toString());
    }
  }

  void _loadHistoryCount() {
    setState(() => _historyCount = context.read<HistoryService>().getAll().length);
  }

  Future<bool> _confirm(String message) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBg1,
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.delete)),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _clearCache() async {
    final l10n = AppLocalizations.of(context)!;
    final cacheService = context.read<CacheService>();
    if (!await _confirm(l10n.clearCacheConfirm)) return;
    if (!mounted) return;
    try {
      await cacheService.clearAllCache();
      await _loadCacheStats();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _clearHistory() async {
    final l10n = AppLocalizations.of(context)!;
    final historyService = context.read<HistoryService>();
    if (!await _confirm(l10n.clearHistoryConfirm)) return;
    if (!mounted) return;
    await historyService.clear();
    _loadHistoryCount();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appSettings = context.watch<AppSettings>();

    return SettingsScaffold(
      title: l10n.privacySettingsTitle,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          ListTile(
            title: Text(l10n.cacheSize),
            subtitle: Text(
              _cacheError ??
                  (_cacheStats == null ? '…' : '${_cacheStats!['locations']} locations · ${_cacheStats!['items']} items'),
              style: const TextStyle(color: AppColors.textMuted),
            ),
            trailing: TextButton(onPressed: _clearCache, child: Text(l10n.clearCache)),
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(l10n.locationHistory),
            subtitle: Text('$_historyCount', style: const TextStyle(color: AppColors.textMuted)),
            trailing: TextButton(onPressed: _clearHistory, child: Text(l10n.clearHistory)),
          ),
          const Divider(height: 1),
          SwitchListTile(
            value: appSettings.gpsEnabled,
            onChanged: appSettings.setGpsEnabled,
            title: Text(l10n.gpsPermission),
            subtitle: Text(l10n.gpsPermissionDesc, style: const TextStyle(color: AppColors.textMuted)),
          ),
          SwitchListTile(
            value: appSettings.reducedMotion,
            onChanged: appSettings.setReducedMotion,
            title: Text(l10n.reducedMotion),
            subtitle: Text(l10n.reducedMotionDesc, style: const TextStyle(color: AppColors.textMuted)),
          ),
          SettingsSectionLabel(l10n.fontSize),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Slider(
              value: appSettings.fontScale,
              min: 0.85,
              max: 1.4,
              divisions: 11,
              activeColor: AppColors.accentAmber,
              label: '${(appSettings.fontScale * 100).round()}%',
              onChanged: appSettings.setFontScale,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
