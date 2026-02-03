import 'package:sqflite/sqflite.dart';

class PersistentCache<T> {
  final Database _db;
  final String _tableName;
  final Duration defaultTtl;
  final T Function(String json) _deserializer;
  final String Function(T data) _serializer;

  CacheEntry<T>? _memoryEntry;

  PersistentCache({
    required Database db,
    required String tableName,
    required T Function(String json) deserializer,
    required String Function(T data) serializer,
    Duration? defaultTtl,
  })  : _db = db,
        _tableName = tableName,
        defaultTtl = defaultTtl ?? const Duration(days: 30),
        _deserializer = deserializer,
        _serializer = serializer;

  static Future<void> initTable(Database db, String tableName) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id TEXT PRIMARY KEY,
        data TEXT NOT NULL,
        cached_at INTEGER NOT NULL
      )
    ''');
  }

  Future<T?> get({Duration? customTtl, String cacheKey = 'default'}) async {
    if (_memoryEntry != null && !_memoryEntry!.isExpired) {
      return _memoryEntry!.data;
    }

    try {
      final results = await _db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [cacheKey],
      );

      if (results.isEmpty) return null;

      final row = results.first;
      final cachedAtMs = row['cached_at'] as int;
      final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMs);
      final ttl = customTtl ?? defaultTtl;

      if (DateTime.now().isAfter(cachedAt.add(ttl))) {
        await _db.delete(_tableName, where: 'id = ?', whereArgs: [cacheKey]);
        return null;
      }

      final data = _deserializer(row['data'] as String);
      _memoryEntry = CacheEntry(data: data, ttl: ttl, cachedAt: cachedAt);
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<void> set(T data, {String cacheKey = 'default'}) async {
    try {
      final json = _serializer(data);
      final now = DateTime.now();

      await _db.insert(
        _tableName,
        {
          'id': cacheKey,
          'data': json,
          'cached_at': now.millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _memoryEntry = CacheEntry(data: data, ttl: defaultTtl);
    } catch (e) {
      // Handle error if necessary
    }
  }

  Future<void> clear({String? cacheKey}) async {
    try {
      if (cacheKey == null) {
        await _db.delete(_tableName);
      } else {
        await _db.delete(_tableName, where: 'id = ?', whereArgs: [cacheKey]);
      }
      _memoryEntry = null;
    } catch (e) {
      // Handle error if necessary
    }
  }

  Future<bool> hasValidData({String cacheKey = 'default'}) async {
    return await get(cacheKey: cacheKey) != null;
  }

  Future<CacheStats?> getStats({String cacheKey = 'default'}) async {
    try {
      final results = await _db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [cacheKey],
      );

      if (results.isEmpty) return null;

      final row = results.first;
      final cachedAtMs = row['cached_at'] as int;
      final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMs);
      final expiresAt = cachedAt.add(defaultTtl);
      final isExpired = DateTime.now().isAfter(expiresAt);
      final remaining = expiresAt.difference(DateTime.now());

      return CacheStats(
        cachedAt: cachedAt,
        expiresAt: expiresAt,
        remainingTtl: remaining.isNegative ? Duration.zero : remaining,
        isExpired: isExpired,
      );
    } catch (e) {
      // Handle error if necessary
      return null;
    }
  }
}

extension PersistentCacheFetch<T> on PersistentCache<T> {
  Future<T> getOrFetch({
    required Future<T> Function() fetcher,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await get();
      if (cached != null) return cached;
    }

    final data = await fetcher();
    await set(data);
    return data;
  }
}

class CacheEntry<T> {
  final T data;
  final DateTime cachedAt;
  final Duration ttl;

  CacheEntry({
    required this.data,
    required this.ttl,
    DateTime? cachedAt,
  }) : cachedAt = cachedAt ?? DateTime.now();

  bool get isExpired {
    final expirationTime = cachedAt.add(ttl);
    return DateTime.now().isAfter(expirationTime);
  }

  Duration get remainingTtl {
    final expirationTime = cachedAt.add(ttl);
    final remaining = expirationTime.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }
}

class CacheStats {
  final DateTime cachedAt;
  final DateTime expiresAt;
  final Duration remainingTtl;
  final bool isExpired;

  CacheStats({
    required this.cachedAt,
    required this.expiresAt,
    required this.remainingTtl,
    required this.isExpired,
  });

  @override
  String toString() =>
      'CacheStats(cachedAt: $cachedAt, expiresAt: $expiresAt, remainingTtl: $remainingTtl, isExpired: $isExpired)';
}
