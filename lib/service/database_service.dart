import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService _instance =
      DatabaseService._privateConstructor();
  factory DatabaseService() => _instance;

  static Database? _db;
  static const _dbName = 'gtfs.db';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE agencies (
            id TEXT PRIMARY KEY,
            json TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE routes (
            id TEXT PRIMARY KEY,
            json TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE trips (
            id TEXT PRIMARY KEY,
            json TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE stop_times (
            trip_id TEXT NOT NULL,
            stop_id TEXT NOT NULL,
            stop_sequence INTEGER NOT NULL,
            json TEXT,
            PRIMARY KEY (trip_id, stop_id, stop_sequence)
          )
        ''');
      },
    );
  }
}
