import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_porto/model/gtfs/agency.dart';
import 'package:in_porto/model/gtfs/route.dart';
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
  static const _keyAgencyUrlOverrides = 'gtfs_agency_url_overrides';

  static const Map<String, String> _defaultAgencyUrls = {
    'Metro do Porto':
        'https://www.metrodoporto.pt/metrodoporto/uploads/document/file/693/google_transit_v2.zip',
    'STCP':
        'https://opendata.porto.digital/dataset/5275c986-592c-43f5-8f87-aabbd4e4f3a4/resource/89a6854f-2ea3-4ba0-8d2f-6558a9df2a98/download/horarios_gtfs_stcp_16_04_2025.zip',
    'Comboios de Portugal': 'http://publico.cp.pt/gtfs/gtfs.zip',
  };

  Future<void> cacheAgencies(List<Agency> agencies) async {
    final database = await db;
    final batch = database.batch();
    for (final agency in agencies) {
      final key = agency.id ?? agency.name;
      batch.insert(
        _agencyTable,
        {'id': key, 'json': jsonEncode(agency.toJson())},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Agency>> loadAgencies() async {
    final database = await db;
    final result = await database.query(_agencyTable);
    return result.map((row) {
      final jsonMap = jsonDecode(row['json'] as String) as Map<String, dynamic>;
      return Agency.fromJson(jsonMap);
    }).toList();
  }

  Future<void> cacheRoutes(List<Route> routes) async {
    final database = await db;
    final batch = database.batch();
    for (final route in routes) {
      batch.insert(
        _routeTable,
        {'id': route.id, 'json': jsonEncode(route.toJson())},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Route>> loadRoutes() async {
    final database = await db;
    final result = await database.query(_routeTable);
    return result.map((row) {
      final jsonMap = jsonDecode(row['json'] as String) as Map<String, dynamic>;
      return Route.fromJson(jsonMap);
    }).toList();
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
    List<Agency> agencies = [];
    List<Route> routes = [];

    List<Map<String, String>> parseCsvFile(String filename) {
      final file = archive.files.firstWhere(
        (f) => f.name.toLowerCase() == filename,
        orElse: () => throw Exception('$filename not found in GTFS zip'),
      );
      final csvString = utf8.decode(file.content as List<int>);
      final rows = const CsvToListConverter(eol: '\n').convert(csvString);
      if (rows.isEmpty) return [];
      final headers = rows.first.map((h) => h.toString()).toList();
      return rows.skip(1).map((row) {
        final map = <String, String>{};
        for (int i = 0; i < headers.length && i < row.length; i++) {
          map[headers[i]] = row[i].toString();
        }
        return map;
      }).toList();
    }

    try {
      final agencyRows = parseCsvFile('agency.txt');
      agencies = agencyRows.map((json) => Agency.fromJson(json)).toList();
    } catch (e) {
      // agency.txt not found or parse error
    }

    try {
      final routeRows = parseCsvFile('routes.txt');
      routes = routeRows.map((json) => Route.fromJson(json)).toList();
    } catch (e) {
      // routes.txt not found or parse error
    }

    return {
      'agencies': agencies,
      'routes': routes,
    };
  }

  /// Checks if GTFS data is available locally, loads from remote if not
  Future<void> ensureGtfsDataLoadedAndPrint() async {
    final agencies = await loadAgencies();
    final routes = await loadRoutes();
    if (agencies.isNotEmpty && routes.isNotEmpty) {
      print('GTFS data loaded locally.');
      print('Agencies:');
      for (final agency in agencies) {
        print(agency.toJson());
      }
      print('Routes:');
      for (final route in routes) {
        print(route.toJson());
      }
      return;
    }
    print('GTFS data not found locally. Loading from remote...');
    for (final entry in _defaultAgencyUrls.entries) {
      try {
        final zipBytes = await fetchGtfsZip(entry.key);
        final parsed = await parseGtfsZip(zipBytes);
        final List<Agency> parsedAgencies = parsed['agencies'] ?? [];
        final List<Route> parsedRoutes = parsed['routes'] ?? [];
        if (parsedAgencies.isNotEmpty) {
          await cacheAgencies(parsedAgencies);
        }
        if (parsedRoutes.isNotEmpty) {
          await cacheRoutes(parsedRoutes);
        }
        print('Loaded and cached data for agency: ${entry.key}');
        print('Agencies:');
        for (final agency in parsedAgencies) {
          print(agency.toJson());
        }
        print('Routes:');
        for (final route in parsedRoutes) {
          print(route.toJson());
        }
      } catch (e) {
        print('Error loading data for ${entry.key}: $e');
      }
    }
  }
}
