import 'dart:convert';
// ...existing code...
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ...existing code...
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:csv/csv.dart';

class GTFSService {
  Database? _db;
  static final GTFSService _instance = GTFSService._privateConstructor();
  GTFSService._privateConstructor();
  factory GTFSService() => _instance;

  void setDatabase(Database db) {
    _db = db;
  }

  Future<Database> get db async {
    if (_db != null) return _db!;
    throw Exception('Database not initialized. Call setDatabase() first.');
  }

  static const _agencyTable = 'agencies';
  static const _routeTable = 'routes';
  static const _tripTable = 'trips';
  static const _stopTimeTable = 'stop_times';
  static const _keyAgencyUrlOverrides = 'gtfs_agency_url_overrides';

  static const Map<String, String> _defaultAgencyUrls = {
    'Metro do Porto':
        'https://www.metrodoporto.pt/metrodoporto/uploads/document/file/693/google_transit_v2.zip',
    'STCP':
        'https://opendata.porto.digital/dataset/5275c986-592c-43f5-8f87-aabbd4e4f3a4/resource/89a6854f-2ea3-4ba0-8d2f-6558a9df2a98/download/horarios_gtfs_stcp_16_04_2025.zip',
    'Comboios de Portugal': 'http://publico.cp.pt/gtfs/gtfs.zip',
  };

  Future<void> cacheAgencies(List<Map<String, dynamic>> agencies) async {
    final database = await db;
    final batch = database.batch();
    for (final agency in agencies) {
      batch.insert(
        _agencyTable,
        agency,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> loadAgencies() async {
    final database = await db;
    return await database.query(_agencyTable);
  }

  Future<void> cacheRoutes(List<Map<String, dynamic>> routes) async {
    final database = await db;
    final batch = database.batch();
    for (final route in routes) {
      batch.insert(
        _routeTable,
        route,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> loadRoutes() async {
    final database = await db;
    return await database.query(_routeTable);
  }

  Future<void> cacheTrips(List<Map<String, dynamic>> trips) async {
    final database = await db;
    final batch = database.batch();
    for (final trip in trips) {
      batch.insert(
        _tripTable,
        trip,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> loadTrips() async {
    final database = await db;
    return await database.query(_tripTable);
  }

  Future<void> cacheStopTimes(List<Map<String, dynamic>> stopTimes) async {
    final database = await db;
    final batch = database.batch();
    for (final stopTime in stopTimes) {
      batch.insert(
        _stopTimeTable,
        stopTime,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> loadStopTimes() async {
    final database = await db;
    return await database.query(_stopTimeTable);
  }

  Future<List<int>> fetchGtfsZip(
    String agencyName, {
    String? overrideUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? url = overrideUrl;
    if (url == null) {
      final overridesJson = prefs.getString(_keyAgencyUrlOverrides);
      if (overridesJson != null) {
        final overrides = jsonDecode(overridesJson) as Map<String, dynamic>;
        url = overrides[agencyName] as String?;
      }
    }
    url ??= _defaultAgencyUrls[agencyName];
    if (url == null) {
      throw Exception('No GTFS URL found for agency: $agencyName');
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to download GTFS zip for $agencyName');
    }
    return response.bodyBytes;
  }

  Future<void> setAgencyUrlOverride(String agencyName, String url) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> overrides = {};
    final overridesJson = prefs.getString(_keyAgencyUrlOverrides);
    if (overridesJson != null) {
      overrides = jsonDecode(overridesJson) as Map<String, dynamic>;
    }
    overrides[agencyName] = url;
    await prefs.setString(_keyAgencyUrlOverrides, jsonEncode(overrides));
  }

  Future<void> removeAgencyUrlOverride(String agencyName) async {
    final prefs = await SharedPreferences.getInstance();
    final overridesJson = prefs.getString(_keyAgencyUrlOverrides);
    if (overridesJson == null) return;
    final overrides = jsonDecode(overridesJson) as Map<String, dynamic>;
    overrides.remove(agencyName);
    await prefs.setString(_keyAgencyUrlOverrides, jsonEncode(overrides));
  }

  Future<Map<String, dynamic>> parseGtfsZip(List<int> zipBytes) async {

    final archive = ZipDecoder().decodeBytes(zipBytes);

    Future<void> streamAndBatchInsert(String filename, String table) async {
      final file = archive.files.firstWhere(
        (f) => f.name.toLowerCase() == filename,
        orElse: () => throw Exception('$filename not found in GTFS zip'),
      );
      final csvString = utf8.decode(file.content as List<int>);
      final lines = const LineSplitter().convert(csvString);
      if (lines.isEmpty) throw Exception('$filename is empty');
      final headers = const CsvToListConverter(
        eol: '\n',
      ).convert(lines.first)[0].map((h) => h.toString()).toList();
      final database = await db;
      final batchSize = 500;
      List<Map<String, dynamic>> batchRows = [];
      for (var i = 1; i < lines.length; i++) {
        final row = const CsvToListConverter(eol: '\n').convert(lines[i])[0];
        final map = <String, dynamic>{};
        for (int j = 0; j < headers.length && j < row.length; j++) {
          map[headers[j]] = row[j];
        }
        batchRows.add(map);
        if (batchRows.length >= batchSize) {
          final batch = database.batch();
          for (final row in batchRows) {
            batch.insert(
              table,
              row,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          await batch.commit(noResult: true);
          batchRows.clear();
        }
      }
      // Insert any remaining rows
      if (batchRows.isNotEmpty) {
        final batch = database.batch();
        for (final row in batchRows) {
          batch.insert(
            table,
            row,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit(noResult: true);
      }
    }

    try {
      await streamAndBatchInsert('agency.txt', _agencyTable);
    } catch (e) {
      // agency.txt not found or parse error
    }
    try {
      await streamAndBatchInsert('routes.txt', _routeTable);
    } catch (e) {
      // routes.txt not found or parse error
    }
    try {
      await streamAndBatchInsert('trips.txt', _tripTable);
    } catch (e) {
      // trips.txt not found or parse error
    }
    try {
      await streamAndBatchInsert('stop_times.txt', _stopTimeTable);
    } catch (e) {
      // stop_times.txt not found or parse error
    }

    // For compatibility, return empty lists (not used for anything)
    return {
      'agencies': [],
      'routes': [],
      'trips': [],
      'stop_times': [],
    };
  }

  /// Checks if GTFS data is available locally, loads from remote if not
  Future<void> ensureGtfsDataLoadedAndPrint() async {
    final database = await db;
    final agenciesCount = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $_agencyTable'),
    ) ?? 0;
    final routesCount = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $_routeTable'),
    ) ?? 0;
    final tripsCount = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $_tripTable'),
    ) ?? 0;
    final stopTimesCount = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $_stopTimeTable'),
    ) ?? 0;
    if (agenciesCount > 0 &&
        routesCount > 0 &&
        tripsCount > 0 &&
        stopTimesCount > 0) {
      print('GTFS data loaded locally. Agencies: $agenciesCount, '
          'Routes: $routesCount, Trips: $tripsCount, Stop Times: $stopTimesCount');
      return;
    }
    print('GTFS data not found locally. Loading from remote...');
    for (final entry in _defaultAgencyUrls.entries) {
      try {
        final zipBytes = await fetchGtfsZip(entry.key);
        await parseGtfsZip(zipBytes);
        print('Loaded and cached raw GTFS data for agency: ${entry.key}');
      } catch (e) {
        print('Error loading data for ${entry.key}: $e');
      }
    }
  }
}
