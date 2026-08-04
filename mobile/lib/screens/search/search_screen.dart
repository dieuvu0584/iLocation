import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../models/location_models.dart';
import '../../services/geocode_service.dart';
import '../../services/history_service.dart';
import '../../state/location_provider.dart';
import '../../theme/colors.dart';
import '../graph/node_graph_screen.dart';
import '../history/history_screen.dart';
import '../settings/settings_home_screen.dart';

/// Entry point of the app. No UI spec existed for this screen (SDD §10) —
/// per the project owner, this is deliberately a simple, functional search
/// box + recent-history list, not a fully designed screen.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

enum _SearchStatus { idle, loading, error }

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  _SearchStatus _status = _SearchStatus.idle;
  List<LocationSearchCandidate> _results = [];
  String? _error;

  Future<void> _search() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _status = _SearchStatus.loading;
      _error = null;
    });

    final geocodeService = context.read<GeocodeService>();
    try {
      final results = await geocodeService.searchCandidates(query);
      if (!mounted) return;
      setState(() {
        _results = results;
        _status = _SearchStatus.idle;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _status = _SearchStatus.error;
      });
    }
  }

  void _openCandidate(LocationSearchCandidate candidate) {
    context.read<LocationProvider>().load(candidate);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NodeGraphScreen()));
  }

  void _openDemo() {
    context.read<LocationProvider>().loadMock();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NodeGraphScreen()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recent = context.watch<HistoryService>().getAll().take(5).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HistoryScreen())),
                    icon: const Icon(Icons.history, color: AppColors.textPrimary),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsHomeScreen())),
                    icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(l10n.appTitle, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _search(),
                decoration: InputDecoration(
                  hintText: l10n.searchHint,
                  prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                  suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward, color: AppColors.accentAmber), onPressed: _search),
                ),
              ),
              const SizedBox(height: 12),
              if (_status == _SearchStatus.loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator(color: AppColors.accentAmber)),
                ),
              if (_status == _SearchStatus.error) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(_error ?? l10n.searchError, style: const TextStyle(color: AppColors.error)),
                ),
                OutlinedButton(onPressed: _openDemo, child: Text(l10n.searchTryDemo)),
              ],
              if (_status == _SearchStatus.idle && _results.isEmpty && _controller.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(l10n.searchNoResults, style: const TextStyle(color: AppColors.textMuted)),
                ),
              if (_results.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(l10n.searchChooseMatch, style: Theme.of(context).textTheme.labelMedium),
                ..._results.map(
                  (c) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.place_outlined, color: AppColors.accentAmber),
                      title: Text(c.name),
                      subtitle: Text(c.formattedAddress, style: const TextStyle(color: AppColors.textMuted)),
                      onTap: () => _openCandidate(c),
                    ),
                  ),
                ),
              ],
              if (recent.isNotEmpty && _results.isEmpty) ...[
                const SizedBox(height: 16),
                Text(l10n.searchRecent, style: Theme.of(context).textTheme.labelMedium),
                ...recent.map(
                  (h) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.history, color: AppColors.textSecondary),
                      title: Text(h.candidate.name),
                      subtitle: Text(h.candidate.formattedAddress, style: const TextStyle(color: AppColors.textMuted)),
                      onTap: () => _openCandidate(h.candidate),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Center(
                child: TextButton(onPressed: _openDemo, child: Text(l10n.searchTryDemo)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
