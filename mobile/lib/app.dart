import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/generated/app_localizations.dart';
import 'screens/search/search_screen.dart';
import 'services/cache_service.dart';
import 'services/geocode_service.dart';
import 'services/history_service.dart';
import 'services/orchestrator_service.dart';
import 'state/app_settings.dart';
import 'state/location_provider.dart';
import 'theme/app_theme.dart';

class LocationExplorerApp extends StatelessWidget {
  final AppSettings appSettings;
  final HistoryService historyService;

  const LocationExplorerApp({
    super.key,
    required this.appSettings,
    required this.historyService,
  });

  @override
  Widget build(BuildContext context) {
    final cacheService = CacheService();
    final orchestrator = OrchestratorService(cache: cacheService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>.value(value: appSettings),
        Provider<HistoryService>.value(value: historyService),
        Provider<CacheService>.value(value: cacheService),
        Provider<GeocodeService>.value(value: GeocodeService()),
        Provider<OrchestratorService>.value(value: orchestrator),
        ChangeNotifierProxyProvider<AppSettings, LocationProvider>(
          create: (_) =>
              LocationProvider(orchestrator: orchestrator, historyService: historyService, appSettings: appSettings),
          update: (_, __, previous) =>
              previous ??
              LocationProvider(orchestrator: orchestrator, historyService: historyService, appSettings: appSettings),
        ),
      ],
      child: Consumer<AppSettings>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Location Explorer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark(fontScale: settings.fontScale),
            locale: settings.uiLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SearchScreen(),
          );
        },
      ),
    );
  }
}
