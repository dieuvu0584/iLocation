import 'package:flutter/material.dart';

import 'app.dart';
import 'services/api_client.dart';
import 'services/history_service.dart';
import 'state/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appSettings = await AppSettings.create();
  final historyService = await HistoryService.create();
  final apiClient = ApiClient()..updateBaseUrl(appSettings.serverBaseUrl);

  runApp(LocationExplorerApp(
    appSettings: appSettings,
    historyService: historyService,
    apiClient: apiClient,
  ));
}
