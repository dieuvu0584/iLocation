import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ilocation/app.dart';
import 'package:ilocation/services/api_client.dart';
import 'package:ilocation/services/history_service.dart';
import 'package:ilocation/state/app_settings.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Search screen renders the search field and title', (tester) async {
    final appSettings = await AppSettings.create();
    final historyService = await HistoryService.create();
    final apiClient = ApiClient(baseUrl: 'http://localhost:8000');

    await tester.pumpWidget(LocationExplorerApp(
      appSettings: appSettings,
      historyService: historyService,
      apiClient: apiClient,
    ));
    await tester.pumpAndSettle();

    expect(find.text('Location Explorer'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
