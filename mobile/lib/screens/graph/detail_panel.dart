import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../models/location_models.dart';
import '../../theme/colors.dart';

/// Slide-up panel shown when a leaf node is tapped (SDD §6). Shows the
/// summary/detail text, a source badge for transparency (SDD §7.2 / §8),
/// any risk disclaimer, and a manual refresh action.
class DetailPanel extends StatelessWidget {
  final ChildItem item;
  final bool showSources;
  final bool isRefreshing;
  final VoidCallback onRefresh;

  const DetailPanel({
    super.key,
    required this.item,
    required this.showSources,
    required this.isRefreshing,
    required this.onRefresh,
  });

  static Future<void> show(
    BuildContext context, {
    required ChildItem item,
    required bool showSources,
    required bool isRefreshing,
    required VoidCallback onRefresh,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DetailPanel(
        item: item,
        showSources: showSources,
        isRefreshing: isRefreshing,
        onRefresh: onRefresh,
      ),
    );
  }

  String _sourceLabel(AppLocalizations l10n) {
    switch (item.source) {
      case 'llm':
        return l10n.detailSourceLlm;
      case 'api':
        return l10n.detailSourceApi;
      case 'search':
        return l10n.detailSourceSearch;
      case 'missing_key':
        return l10n.detailSourceMissingKey;
      default:
        return l10n.detailSourceStatic;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.cardBg2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: AppColors.borderColor)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(color: AppColors.borderColor, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text(item.label, style: textTheme.headlineSmall)),
                  IconButton(
                    tooltip: l10n.graphRefresh,
                    onPressed: isRefreshing ? null : onRefresh,
                    icon: isRefreshing
                        ? const SizedBox(
                            width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accentAmber))
                        : const Icon(Icons.refresh, color: AppColors.accentAmber),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _SourceBadge(label: _sourceLabel(l10n)),
              const SizedBox(height: 16),
              Text(item.summary, style: textTheme.titleMedium),
              if (item.detail.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(item.detail, style: textTheme.bodyMedium),
              ],
              if (item.warning != null) ...[
                const SizedBox(height: 16),
                _WarningBanner(text: item.warning!),
              ],
              if (item.isStale) ...[
                const SizedBox(height: 12),
                Text(l10n.detailStale, style: textTheme.bodySmall?.copyWith(color: AppColors.error)),
              ],
              const SizedBox(height: 16),
              Text(
                l10n.detailUpdatedAt(DateFormat.yMMMd().add_Hm().format(item.updatedAt.toLocal())),
                style: textTheme.bodySmall,
              ),
              if (showSources && item.sources.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(l10n.detailSources, style: textTheme.titleSmall),
                const SizedBox(height: 8),
                ...item.sources.map(
                  (url) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      url,
                      style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SourceBadge extends StatelessWidget {
  final String label;
  const _SourceBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBg1,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
    );
  }
}

class _WarningBanner extends StatelessWidget {
  final String text;
  const _WarningBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13))),
        ],
      ),
    );
  }
}
