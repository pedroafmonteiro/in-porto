import 'package:sqflite/sqflite.dart';
import 'package:sqflite_live/sqflite_live.dart';
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
            agency_id TEXT PRIMARY KEY,
            agency_name TEXT NOT NULL,
            agency_url TEXT NOT NULL,
            agency_timezone TEXT NOT NULL,
            agency_lang TEXT,
            agency_phone TEXT,
            agency_fare_url TEXT,
            agency_email TEXT
          )
        ''');
          await db.execute('''
          CREATE TABLE stops (
            stop_id TEXT PRIMARY KEY,
            stop_code TEXT,
            stop_name TEXT NOT NULL,
            tts_stop_name TEXT,
            stop_desc TEXT,
            stop_lat REAL NOT NULL,
            stop_lon REAL NOT NULL,
            zone_id TEXT,
            stop_url TEXT,
            location_type INTEGER,
            parent_station TEXT,
            stop_timezone TEXT,
            wheelchair_boarding INTEGER,
            level_id TEXT,
            platform_code TEXT
          )
        ''');
          await db.execute('''
          CREATE TABLE routes (
            route_id TEXT PRIMARY KEY,
            agency_id TEXT,
            route_short_name TEXT,
            route_long_name TEXT,
            route_desc TEXT,
            route_type INTEGER NOT NULL,
            route_url TEXT,
            route_color TEXT,
            route_text_color TEXT,
            route_sort_order INTEGER,
            continuous_pickup INTEGER,
            continuous_drop_off INTEGER,
            network_id TEXT,
            FOREIGN KEY (agency_id) REFERENCES agencies (agency_id)
          )
        ''');
          await db.execute('''
          CREATE TABLE trips (
            route_id TEXT NOT NULL,
            service_id TEXT NOT NULL,
            trip_id TEXT PRIMARY KEY,
            trip_headsign TEXT,
            trip_short_name TEXT,
            direction_id INTEGER,
            block_id TEXT,
            shape_id TEXT,
            wheelchair_accessible INTEGER,
            bikes_allowed INTEGER,
            cars_allowed INTEGER,
            FOREIGN KEY (route_id) REFERENCES routes (route_id),
            FOREIGN KEY (service_id) REFERENCES calendars (service_id)
          )
        ''');
          await db.execute('''
          CREATE TABLE stop_times (
            trip_id TEXT NOT NULL,
            arrival_time TEXT,
            departure_time TEXT,
            stop_id TEXT,
            location_group_id TEXT,
            location_id TEXT,
            stop_sequence INTEGER NOT NULL,
            stop_headsign TEXT,
            start_pickup_drop_off_window TEXT,
            end_pickup_drop_off_window TEXT,
            pickup_type INTEGER,
            drop_off_type INTEGER,
            continuous_pickup INTEGER,
            continuous_drop_off INTEGER,
            shape_dist_traveled REAL,
            timepoint INTEGER,
            pickup_booking_rule_id TEXT,
            drop_off_booking_rule_id TEXT,
            PRIMARY KEY (trip_id, stop_sequence),
            FOREIGN KEY (trip_id) REFERENCES trips (trip_id),
            FOREIGN KEY (stop_id) REFERENCES stops (stop_id)
          )
        ''');
          await db.execute('''
          CREATE TABLE calendars (
            service_id TEXT PRIMARY KEY,
            monday INTEGER NOT NULL,
            tuesday INTEGER NOT NULL,
            wednesday INTEGER NOT NULL,
            thursday INTEGER NOT NULL,
            friday INTEGER NOT NULL,
            saturday INTEGER NOT NULL,
            sunday INTEGER NOT NULL,
            start_date TEXT NOT NULL,
            end_date TEXT NOT NULL
          )
        ''');
          await db.execute('''
          CREATE TABLE calendars_dates (
            service_id TEXT NOT NULL,
            date TEXT NOT NULL,
            exception_type INTEGER NOT NULL,
            PRIMARY KEY (service_id, date),
            FOREIGN KEY (service_id) REFERENCES calendars (service_id)
          )
        ''');
          await db.execute('''
          CREATE TABLE shapes (
            shape_id TEXT,
            shape_pt_lat REAL NOT NULL,
            shape_pt_lon REAL NOT NULL,
            shape_pt_sequence INTEGER NOT NULL,
            shape_dist_traveled REAL,
            PRIMARY KEY (shape_id, shape_pt_sequence)
          )
        ''');
        },
      )
      ..live();
  }
}
