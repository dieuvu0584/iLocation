import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../services/history_service.dart';
import '../../state/location_provider.dart';
import '../../theme/colors.dart';
import '../../widgets/common/candidate_title.dart';
import '../graph/node_graph_screen.dart';

/// Simple, functional recent-locations list (SDD §10 — no formal spec
/// existed for this screen; kept intentionally minimal per project owner).
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<HistoryEntry> _entries;

  @override
  void initState() {
    super.initState();
    _entries = context.read<HistoryService>().getAll();
  }

  Future<void> _remove(HistoryEntry entry) async {
    await context.read<HistoryService>().remove(entry.candidate.locationId);
    setState(() => _entries = context.read<HistoryService>().getAll());
  }

  Future<void> _clearAll() async {
    await context.read<HistoryService>().clear();
    setState(() => _entries = []);
  }

  void _open(HistoryEntry entry) {
    context.read<LocationProvider>().load(entry.candidate);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NodeGraphScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                    Expanded(child: Text(l10n.historyTitle, style: Theme.of(context).textTheme.headlineSmall)),
                    if (_entries.isNotEmpty)
                      TextButton(onPressed: _clearAll, child: Text(l10n.clearHistory)),
                  ],
                ),
              ),
              Expanded(
                child: _entries.isEmpty
                    ? Center(child: Text(l10n.historyEmpty, style: const TextStyle(color: AppColors.textMuted)))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: _entries.length,
                        itemBuilder: (context, index) {
                          final entry = _entries[index];
                          return Dismissible(
                            key: ValueKey(entry.candidate.locationId),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => _remove(entry),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete_outline, color: AppColors.error),
                            ),
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.place_outlined, color: AppColors.accentAmber),
                                title: CandidateTitle(name: entry.candidate.name, localName: entry.candidate.localName),
                                subtitle: Text(
                                  '${entry.candidate.formattedAddress} · ${DateFormat.yMMMd().format(entry.viewedAt)}',
                                  style: const TextStyle(color: AppColors.textMuted),
                                ),
                                onTap: () => _open(entry),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
