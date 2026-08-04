import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app.dart';
import 'services/history_service.dart';
import 'state/app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // `sqflite` only ships native implementations for Android/iOS/macOS. On
  // Linux/Windows desktop (used for local dev/verification, never the
  // shipped app's real target), fall back to the FFI-backed sqlite3 factory.
  if (!kIsWeb && (Platform.isLinux || Platform.isWindows)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final appSettings = await AppSettings.create();
  final historyService = await HistoryService.create();

  runApp(LocationExplorerApp(
    appSettings: appSettings,
    historyService: historyService,
  ));
}
