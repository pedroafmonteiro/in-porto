import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/shape_coordinates.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/entities/trip.dart';

abstract class TransportAgencyRepository {
  Future<List<Stop>> getStops({bool forceRefresh = false});
  Future<List<TransportRoute>> getRoutes({bool forceRefresh = false});
  Future<String> fetchStopServiceId(Stop stop, DateTime? date);
  Future<List<TransportRoute>> fetchStopRoutes(Stop stop);
  Future<List<Schedule>> fetchStopRouteSchedules(
    Stop stop,
    TransportRoute route,
    String serviceId,
  );
  Future<(DateTime, List<Trip>)> fetchStopRealtimeTrips(Stop stop);
  Future<List<ShapeCoordinates>> fetchRouteShapeCoordinates(
    TransportRoute route,
  );
  Future<List<Stop>> fetchRouteStops(TransportRoute route);
}
