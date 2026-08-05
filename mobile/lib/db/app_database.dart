import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// On-device cache DB (SDD §5 cache strategy, ported from the original
/// backend's SQLite schema — see CLAUDE.md "Quyết định đã chốt 2026-08-04
/// (đợt 2)"). No server involved: this file lives entirely on the phone.
class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    _db ??= await _open();
    return _db!;
  }

  static Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ilocation_cache.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE locations (
            location_id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            lat REAL NOT NULL,
            lng REAL NOT NULL,
            country_code TEXT,
            country TEXT,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE cache_items (
            location_id TEXT NOT NULL,
            item_id TEXT NOT NULL,
            group_id TEXT NOT NULL,
            label TEXT NOT NULL,
            source TEXT NOT NULL,
            summary TEXT NOT NULL,
            detail TEXT NOT NULL DEFAULT '',
            sources_json TEXT NOT NULL DEFAULT '[]',
            warning TEXT,
            updated_at TEXT NOT NULL,
            expires_at TEXT,
            PRIMARY KEY (location_id, item_id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE locations ADD COLUMN country TEXT');
        }
      },
    );
  }

  /// Test-only: point at an isolated in-memory/temp DB instead of the
  /// shared singleton.
  static void resetForTests(Database db) {
    _db = db;
  }
}
