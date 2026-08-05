import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../models/location_models.dart';
import '../../state/app_settings.dart';
import '../../state/location_provider.dart';
import '../../theme/colors.dart';
import '../../widgets/node_graph/connector_painter.dart';
import '../../widgets/node_graph/graph_icons.dart';
import '../../widgets/node_graph/graph_node.dart';
import '../../widgets/node_graph/ring_layout.dart';
import '../history/history_screen.dart';
import '../settings/settings_home_screen.dart';
import 'detail_panel.dart';

/// The main 2-tier node-graph view (SDD §6). Tier 1: 5 group nodes around
/// the location. Tap a group -> tier 2: that group's children around it,
/// with a breadcrumb + back to return.
class NodeGraphScreen extends StatefulWidget {
  const NodeGraphScreen({super.key});

  @override
  State<NodeGraphScreen> createState() => _NodeGraphScreenState();
}

class _NodeGraphScreenState extends State<NodeGraphScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ambientController;
  String? _activeGroupId; // null = tier 1

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(vsync: this, duration: const Duration(seconds: 7))..repeat();
  }

  @override
  void dispose() {
    _ambientController.dispose();
    super.dispose();
  }

  bool _reducedMotion(BuildContext context) {
    final appSettings = context.watch<AppSettings>();
    return appSettings.reducedMotion || MediaQuery.of(context).disableAnimations;
  }

  void _openGroup(String groupId) => setState(() => _activeGroupId = groupId);

  void _backToTier1() => setState(() => _activeGroupId = null);

  Future<void> _openDetail(BuildContext context, ChildItem item) async {
    final locationProvider = context.read<LocationProvider>();
    final showSources = context.read<AppSettings>().showSources;
    final candidate = locationProvider.candidate;
    await DetailPanel.show(
      context,
      item: item,
      showSources: showSources,
      isRefreshing: locationProvider.refreshingItemIds.contains(item.id),
      onRefresh: () => locationProvider.refreshItem(item.id),
      locationLat: candidate?.lat,
      locationLng: candidate?.lng,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locationProvider = context.watch<LocationProvider>();
    final reducedMotion = _reducedMotion(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _Header(
                onSearch: () => Navigator.of(context).pop(),
                onHistory: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HistoryScreen())),
                onSettings: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsHomeScreen())),
              ),
              if (_activeGroupId != null) _Breadcrumb(groupLabel: _groupLabel(locationProvider), onBack: _backToTier1),
              Expanded(child: _buildBody(context, l10n, locationProvider, reducedMotion)),
            ],
          ),
        ),
      ),
    );
  }

  String _groupLabel(LocationProvider provider) {
    final group = provider.response?.groupById(_activeGroupId ?? '');
    return group?.label ?? '';
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    LocationProvider provider,
    bool reducedMotion,
  ) {
    switch (provider.status) {
      case LocationLoadStatus.idle:
      case LocationLoadStatus.loading:
        return _LoadingView(label: l10n.graphLoading);
      case LocationLoadStatus.error:
        return _ErrorView(
          message: provider.errorMessage ?? l10n.graphError,
          retryLabel: l10n.graphRetry,
          onRetry: () {
            final candidate = provider.candidate;
            if (candidate != null) provider.load(candidate);
          },
        );
      case LocationLoadStatus.loaded:
        final response = provider.response!;
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            final radius = (size.shortestSide / 2 - 56).clamp(112.0, 190.0);

            final List<_NodeSpec> ringSpecs;
            final String centerLabel;
            final String? centerSublabel;
            if (_activeGroupId == null) {
              centerLabel = response.location.name;
              centerSublabel = response.location.country;
              ringSpecs = response.groups
                  .map((g) => _NodeSpec(id: g.id, label: g.label, icon: iconForGroup(g.id), item: null))
                  .toList();
            } else {
              final group = response.groupById(_activeGroupId!);
              centerLabel = group?.label ?? '';
              centerSublabel = null;
              ringSpecs = (group?.children ?? [])
                  .map((c) => _NodeSpec(id: c.id, label: c.label, icon: iconForChild(c.id), item: c))
                  .toList();
            }

            final positions = ringPositions(ringSpecs.length, radius);

            return Center(
              child: SizedBox(
                width: size.shortestSide,
                height: size.shortestSide,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _ambientController,
                      builder: (context, _) => CustomPaint(
                        size: Size(size.shortestSide, size.shortestSide),
                        painter: ConnectorPainter(
                          targets: positions,
                          animationValue: _ambientController.value,
                          reducedMotion: reducedMotion,
                        ),
                      ),
                    ),
                    for (var i = 0; i < ringSpecs.length; i++)
                      RingNode(
                        label: ringSpecs[i].label,
                        icon: ringSpecs[i].icon,
                        basePosition: Offset(size.shortestSide / 2, size.shortestSide / 2) + positions[i],
                        animation: _ambientController,
                        phase: i * 0.9,
                        reducedMotion: reducedMotion,
                        isLoading: ringSpecs[i].item != null && provider.refreshingItemIds.contains(ringSpecs[i].item!.id),
                        hasWarning: ringSpecs[i].item?.warning != null,
                        onTap: () {
                          final item = ringSpecs[i].item;
                          if (item != null) {
                            _openDetail(context, item);
                          } else {
                            _openGroup(ringSpecs[i].id);
                          }
                        },
                      ),
                    CenterNode(
                      label: centerLabel,
                      sublabel: centerSublabel,
                      animation: _ambientController,
                      reducedMotion: reducedMotion,
                      onTap: _activeGroupId == null ? null : _backToTier1,
                    ),
                  ],
                ),
              ),
            );
          },
        );
    }
  }
}

class _NodeSpec {
  final String id;
  final String label;
  final IconData icon;
  final ChildItem? item;
  const _NodeSpec({required this.id, required this.label, required this.icon, required this.item});
}

class _Header extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onHistory;
  final VoidCallback onSettings;

  const _Header({required this.onSearch, required this.onHistory, required this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(onPressed: onSearch, icon: const Icon(Icons.search, color: AppColors.textPrimary)),
          const Spacer(),
          IconButton(onPressed: onHistory, icon: const Icon(Icons.history, color: AppColors.textPrimary)),
          IconButton(onPressed: onSettings, icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _Breadcrumb extends StatelessWidget {
  final String groupLabel;
  final VoidCallback onBack;

  const _Breadcrumb({required this.groupLabel, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, size: 18, color: AppColors.accentAmber),
            label: Text(l10n.graphBack, style: const TextStyle(color: AppColors.accentAmber)),
          ),
          const SizedBox(width: 4),
          Text(groupLabel, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String label;
  const _LoadingView({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.accentAmber),
          const SizedBox(height: 16),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.retryLabel, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, color: AppColors.textMuted, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: Text(retryLabel)),
          ],
        ),
      ),
    );
  }
}
