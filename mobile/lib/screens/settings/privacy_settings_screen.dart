import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../services/api_client.dart';
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
  late final TextEditingController _serverUrlController;

  @override
  void initState() {
    super.initState();
    _serverUrlController = TextEditingController(text: context.read<AppSettings>().serverBaseUrl ?? '');
    _loadCacheStats();
    _loadHistoryCount();
  }

  @override
  void dispose() {
    _serverUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveServerUrl() async {
    final url = _serverUrlController.text.trim();
    await context.read<AppSettings>().setServerBaseUrl(url.isEmpty ? null : url);
    if (!mounted) return;
    context.read<ApiClient>().updateBaseUrl(url.isEmpty ? null : url);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${AppLocalizations.of(context)!.save}: ${context.read<ApiClient>().baseUrl}')),
    );
  }

  Future<void> _loadCacheStats() async {
    try {
      final stats = await context.read<ApiClient>().getCacheStats();
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
    final apiClient = context.read<ApiClient>();
    if (!await _confirm(l10n.clearCacheConfirm)) return;
    if (!mounted) return;
    try {
      await apiClient.clearCache();
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

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
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
          SettingsSectionLabel(l10n.serverUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: Text(l10n.serverUrlDesc, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _serverUrlController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: l10n.serverUrlHint,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.save_outlined, color: AppColors.accentAmber),
                  onPressed: _saveServerUrl,
                ),
              ),
              onSubmitted: (_) => _saveServerUrl(),
            ),
          ),
          const Divider(height: 24),
          ListTile(
            title: Text(l10n.cacheSize),
            subtitle: Text(
              _cacheError ??
                  (_cacheStats == null
                      ? '…'
                      : '${_formatBytes(_cacheStats!['size_bytes'] as int? ?? 0)} · ${_cacheStats!['locations']} locations'),
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
