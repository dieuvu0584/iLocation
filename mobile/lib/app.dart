import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/generated/app_localizations.dart';
import 'screens/search/search_screen.dart';
import 'services/api_client.dart';
import 'services/history_service.dart';
import 'state/app_settings.dart';
import 'state/location_provider.dart';
import 'theme/app_theme.dart';

class LocationExplorerApp extends StatelessWidget {
  final AppSettings appSettings;
  final HistoryService historyService;
  final ApiClient apiClient;

  const LocationExplorerApp({
    super.key,
    required this.appSettings,
    required this.historyService,
    required this.apiClient,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppSettings>.value(value: appSettings),
        Provider<HistoryService>.value(value: historyService),
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProxyProvider<AppSettings, LocationProvider>(
          create: (_) => LocationProvider(apiClient: apiClient, historyService: historyService, appSettings: appSettings),
          update: (_, __, previous) =>
              previous ?? LocationProvider(apiClient: apiClient, historyService: historyService, appSettings: appSettings),
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
