import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/colors.dart';

/// A small "Get an API key" link shown under a BYOK key field, pointing at
/// the provider's own key-creation page. Opens in the external browser —
/// same `url_launcher` mechanism as the "Signature photos" node
/// (`photo_link_service.dart` / `detail_panel.dart`).
class GetApiKeyLink extends StatelessWidget {
  final String url;
  const GetApiKeyLink({super.key, required this.url});

  Future<void> _open(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    try {
      final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.searchError)));
      }
    } catch (_) {
      if (context.mounted) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.searchError)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => _open(context),
        icon: const Icon(Icons.open_in_new, size: 14, color: AppColors.accentAmber),
        label: Text(l10n.getApiKeyLink, style: const TextStyle(color: AppColors.accentAmber, fontSize: 13)),
        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    );
  }
}
