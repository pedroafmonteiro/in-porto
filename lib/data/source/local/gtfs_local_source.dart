import 'objectbox.dart';
import '../../model/gtfs/agency.dart';
import '../../model/gtfs/calendar.dart';
import '../../model/gtfs/calendar_date.dart';
import '../../model/gtfs/route.dart';
import '../../model/gtfs/trip.dart';
import '../../model/gtfs/stop.dart';
import '../../model/gtfs/stop_time.dart';
import '../../model/gtfs/shape.dart';
import '../../../objectbox.g.dart';

class GtfsLocalDataSource {
  static const _agencyTable = 'agencies';
  static const _stopTable = 'stops';
  static const _routeTable = 'routes';
  static const _tripTable = 'trips';
  static const _stopTimeTable = 'stop_times';
  static const _calendarTable = 'calendars';
  static const _calendarDatesTable = 'calendars_dates';
  static const _shapeTable = 'shapes';

  String _currentTable = '';
  final Map<String, int> _agencyIdCache = {};
  final Map<String, int> _routeIdCache = {};
  final Map<String, int> _tripIdCache = {};
  final Map<String, int> _stopIdCache = {};
  final Map<String, int> _calendarIdCache = {};

  Future<void> insertBatch(
    String table,
    Iterable<Map<String, dynamic>> rows, {
    Function(double)? onProgress,
    int? totalRows,
  }) async {
    final store = await ObjectBox.getStore();
    final total = totalRows ?? (rows is List ? rows.length : 0);
    final batchSize = 500;
    int processed = 0;

    if (_currentTable != table) {
      _currentTable = table;
      _clearCaches();
      await _preloadCache(store, table);
    }

    List<dynamic> batch = [];
    for (final row in rows) {
      final entity = _mapRowToEntity(table, row);
      if (entity != null) {
        batch.add(entity);
      }
      processed++;

      if (batch.length >= batchSize) {
        _putBatch(store, table, batch);
        batch = [];
        if (onProgress != null && total > 0) {
          onProgress(processed / total);
          await Future.delayed(Duration.zero);
        }
      }
    }

    if (batch.isNotEmpty) {
      _putBatch(store, table, batch);
      if (onProgress != null && total > 0) {
        onProgress(processed / total);
      }
    }
  }

  void _putBatch(Store store, String table, List<dynamic> batch) {
    if (batch.isEmpty) return;
    switch (table) {
      case _agencyTable:
        store.box<Agency>().putMany(batch.cast<Agency>());
        break;
      case _stopTable:
        store.box<Stop>().putMany(batch.cast<Stop>());
        break;
      case _routeTable:
        store.box<Route>().putMany(batch.cast<Route>());
        break;
      case _tripTable:
        store.box<Trip>().putMany(batch.cast<Trip>());
        break;
      case _stopTimeTable:
        store.box<StopTime>().putMany(batch.cast<StopTime>());
        break;
      case _calendarTable:
        store.box<Calendar>().putMany(batch.cast<Calendar>());
        break;
      case _calendarDatesTable:
        store.box<CalendarDate>().putMany(batch.cast<CalendarDate>());
        break;
      case _shapeTable:
        store.box<Shape>().putMany(batch.cast<Shape>());
        break;
    }
  }

  dynamic _mapRowToEntity(String table, Map<String, dynamic> row) {
    switch (table) {
      case _agencyTable:
        return Agency.fromMap(row);
      case _stopTable:
        return Stop.fromMap(row);
      case _routeTable:
        final route = Route.fromMap(row);
        if (route.agencyIdString != null &&
            _agencyIdCache.containsKey(route.agencyIdString)) {
          route.agency.targetId = _agencyIdCache[route.agencyIdString]!;
        }
        return route;
      case _tripTable:
        final trip = Trip.fromMap(row);
        if (_routeIdCache.containsKey(trip.routeGtfsId)) {
          trip.route.targetId = _routeIdCache[trip.routeGtfsId]!;
        }
        if (_calendarIdCache.containsKey(trip.serviceId)) {
          trip.calendar.targetId = _calendarIdCache[trip.serviceId]!;
        }
        return trip;
      case _stopTimeTable:
        final stopTime = StopTime.fromMap(row);
        if (_tripIdCache.containsKey(stopTime.tripGtfsId)) {
          stopTime.trip.targetId = _tripIdCache[stopTime.tripGtfsId]!;
        }
        if (stopTime.stopGtfsId != null &&
            _stopIdCache.containsKey(stopTime.stopGtfsId)) {
          stopTime.stop.targetId = _stopIdCache[stopTime.stopGtfsId]!;
        }
        return stopTime;
      case _calendarTable:
        return Calendar.fromMap(row);
      case _calendarDatesTable:
        return CalendarDate.fromMap(row);
      case _shapeTable:
        return Shape.fromMap(row);
      default:
        return null;
    }
  }

  void _clearCaches() {
    _agencyIdCache.clear();
    _routeIdCache.clear();
    _tripIdCache.clear();
    _stopIdCache.clear();
    _calendarIdCache.clear();
  }

  Future<void> _preloadCache(Store store, String table) async {
    switch (table) {
      case _routeTable:
        final agencyBox = store.box<Agency>();
        final agencies = agencyBox.getAll();
        for (var a in agencies) {
          _agencyIdCache[a.agencyId] = a.id;
        }
        break;
      case _tripTable:
        final routeBox = store.box<Route>();
        final routeQuery = routeBox.query().build();
        final routeIds = routeQuery.findIds();
        final routeGtfsIds = routeQuery.property(Route_.routeId).find();
        routeQuery.close();

        if (routeIds.length == routeGtfsIds.length) {
          for (int i = 0; i < routeIds.length; i++) {
            _routeIdCache[routeGtfsIds[i]] = routeIds[i];
          }
        }

        final calendarBox = store.box<Calendar>();
        final calendarQuery = calendarBox.query().build();
        final calendarIds = calendarQuery.findIds();
        final calendarServiceIds = calendarQuery
            .property(Calendar_.serviceId)
            .find();
        calendarQuery.close();

        if (calendarIds.length == calendarServiceIds.length) {
          for (int i = 0; i < calendarIds.length; i++) {
            _calendarIdCache[calendarServiceIds[i]] = calendarIds[i];
          }
        }
        break;
      case _stopTimeTable:
        final stopBox = store.box<Stop>();
        final stopQuery = stopBox.query().build();
        final stopIds = stopQuery.findIds();
        final stopGtfsIds = stopQuery.property(Stop_.stopId).find();
        stopQuery.close();
        if (stopIds.length == stopGtfsIds.length) {
          for (int i = 0; i < stopIds.length; i++) {
            _stopIdCache[stopGtfsIds[i]] = stopIds[i];
          }
        }

        final tripBox = store.box<Trip>();
        final tripQuery = tripBox.query().build();
        final tripIds = tripQuery.findIds();
        final tripGtfsIds = tripQuery.property(Trip_.tripId).find();
        tripQuery.close();
        if (tripIds.length == tripGtfsIds.length) {
          for (int i = 0; i < tripIds.length; i++) {
            _tripIdCache[tripGtfsIds[i]] = tripIds[i];
          }
        }
        break;
    }
  }

  Future<void> deleteAll() async {
    final store = await ObjectBox.getStore();
    store.box<Agency>().removeAll();
    store.box<Route>().removeAll();
    store.box<Trip>().removeAll();
    store.box<Stop>().removeAll();
    store.box<StopTime>().removeAll();
    store.box<Calendar>().removeAll();
    store.box<CalendarDate>().removeAll();
    store.box<Shape>().removeAll();
    _currentTable = '';
    _clearCaches();
  }

  Future<void> clearDataForAgency(String agencyId) async {
    final store = await ObjectBox.getStore();

    final stopBox = store.box<Stop>();
    final stopQuery = stopBox.query(Stop_.agencyId.equals(agencyId)).build();
    stopQuery.remove();
    stopQuery.close();

    final shapeBox = store.box<Shape>();
    final shapeQuery = shapeBox.query(Shape_.agencyId.equals(agencyId)).build();
    shapeQuery.remove();
    shapeQuery.close();

    final calendarBox = store.box<Calendar>();
    final calendarQuery = calendarBox.query(Calendar_.agencyId.equals(agencyId)).build();
    calendarQuery.remove();
    calendarQuery.close();

    final calendarDateBox = store.box<CalendarDate>();
    final calendarDateQuery = calendarDateBox.query(CalendarDate_.agencyId.equals(agencyId)).build();
    calendarDateQuery.remove();
    calendarDateQuery.close();

    final gtfsAgencyBox = store.box<Agency>();
    final agencyQuery = gtfsAgencyBox
        .query(Agency_.agencyId.equals(agencyId))
        .build();
    final agencies = agencyQuery.find();
    agencyQuery.close();

    if (agencies.isEmpty) return;

    for (final agency in agencies) {
      final agencyInternalId = agency.id;

      final routeBox = store.box<Route>();
      final routeQuery = routeBox
          .query(Route_.agency.equals(agencyInternalId))
          .build();
      final routes = routeQuery.find();
      routeQuery.close();

      final tripBox = store.box<Trip>();
      final stopTimeBox = store.box<StopTime>();

      for (final route in routes) {
        final tripQuery = tripBox.query(Trip_.route.equals(route.id)).build();
        final trips = tripQuery.find();
        tripQuery.close();

        for (final trip in trips) {
          final stopTimeQuery = stopTimeBox
              .query(StopTime_.trip.equals(trip.id))
              .build();
          stopTimeQuery.remove();
          stopTimeQuery.close();
        }

        tripBox.removeMany(trips.map((t) => t.id).toList());
      }

      routeBox.removeMany(routes.map((r) => r.id).toList());

      gtfsAgencyBox.remove(agencyInternalId);
    }
  }

  Future<Map<String, int>> getDataCounts() async {
    final store = await ObjectBox.getStore();
    return {
      'agencies': store.box<Agency>().count(),
      'stops': store.box<Stop>().count(),
      'routes': store.box<Route>().count(),
      'trips': store.box<Trip>().count(),
      'stop_times': store.box<StopTime>().count(),
      'calendars': store.box<Calendar>().count(),
      'calendars_dates': store.box<CalendarDate>().count(),
      'shapes': store.box<Shape>().count(),
    };
  }

  Future<bool> hasDataForAgency(String agencyId) async {
    final store = await ObjectBox.getStore();
    final query = store
        .box<Route>()
        .query(Route_.agencyIdString.equals(agencyId))
        .build();
    final count = query.count();
    query.close();
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
