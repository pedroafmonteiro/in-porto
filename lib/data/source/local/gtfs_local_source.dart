import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class GtfsLocalDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  static const _agencyTable = 'agencies';
  static const _stopTable = 'stops';
  static const _routeTable = 'routes';
  static const _tripTable = 'trips';
  static const _stopTimeTable = 'stop_times';
  static const _calendarTable = 'calendars';
  static const _calendarDatesTable = 'calendars_dates';
  static const _shapeTable = 'shapes';

  Future<void> insertBatch(
    String table,
    Iterable<Map<String, dynamic>> rows, {
    Function(double)? onProgress,
    int? totalRows,
  }) async {
    final db = await _dbHelper.db;

    final total = totalRows ?? (rows is List ? rows.length : 0);
    final batchSize = 500;
    int processed = 0;

    await db.transaction((txn) async {
      var batch = txn.batch();

      for (final row in rows) {
        batch.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
        processed++;

        if (processed % batchSize == 0) {
          await batch.commit(noResult: true);
          batch = txn.batch();

          if (onProgress != null && total > 0) {
            onProgress(processed / total);
          }
        }
      }

      await batch.commit(noResult: true);
    });

    if (onProgress != null) {
      onProgress(1.0);
    }
  }

  Future<void> deleteAll() async {
    final db = await _dbHelper.db;
    await db.transaction((txn) async {
      await txn.execute('DELETE FROM $_agencyTable');
      await txn.execute('DELETE FROM $_stopTable');
      await txn.execute('DELETE FROM $_routeTable');
      await txn.execute('DELETE FROM $_tripTable');
      await txn.execute('DELETE FROM $_stopTimeTable');
      await txn.execute('DELETE FROM $_calendarTable');
      await txn.execute('DELETE FROM $_calendarDatesTable');
      await txn.execute('DELETE FROM $_shapeTable');
    });
  }

  Future<Map<String, int>> getDataCounts() async {
    final db = await _dbHelper.db;
    return {
      'agencies':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_agencyTable'),
          ) ??
          0,
      'stops':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_stopTable'),
          ) ??
          0,
      'routes':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_routeTable'),
          ) ??
          0,
      'trips':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_tripTable'),
          ) ??
          0,
      'stop_times':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_stopTimeTable'),
          ) ??
          0,
      'calendars':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_calendarTable'),
          ) ??
          0,
      'calendars_dates':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_calendarDatesTable'),
          ) ??
          0,
      'shapes':
          Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $_shapeTable'),
          ) ??
          0,
    };
  }

  Future<bool> hasDataForAgency(String agencyId) async {
    final db = await _dbHelper.db;
    final count =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM $_routeTable WHERE agency_id = ?',
            [agencyId],
          ),
        ) ??
        0;
    return count > 0;
  }

  String get agencyTable => _agencyTable;
  String get stopTable => _stopTable;
  String get routeTable => _routeTable;
  String get tripTable => _tripTable;
  String get stopTimeTable => _stopTimeTable;
  String get calendarTable => _calendarTable;
  String get calendarDatesTable => _calendarDatesTable;
  String get shapeTable => _shapeTable;
}
