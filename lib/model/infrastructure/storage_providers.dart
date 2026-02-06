import 'dart:convert';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:in_porto/model/infrastructure/cache.dart';
import 'package:in_porto/model/entities/stop.dart';

part 'storage_providers.g.dart';

@riverpod
Future<Database> cacheDatabase(Ref ref) async {
  final dbPath = join(await getDatabasesPath(), 'app_cache.db');
  final db = await openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) async {
      await PersistentCache.initTable(db, 'stops_cache');
    },
  );
  return db;
}

@riverpod
Future<PersistentCache<List<Stop>>> stopsCache(Ref ref) async {
  final db = await ref.watch(cacheDatabaseProvider.future);
  return PersistentCache(
    db: db,
    tableName: 'stops_cache',
    deserializer: (json) {
      final list = jsonDecode(json) as List;
      return list.map((e) => Stop.fromJson(e as Map<String, dynamic>)).toList();
    },
    serializer: (stops) => jsonEncode(stops.map((s) => s.toJson()).toList()),
    defaultTtl: const Duration(days: 30),
  );
}
