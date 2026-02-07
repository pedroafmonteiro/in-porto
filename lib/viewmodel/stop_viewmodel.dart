import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/trip.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/repositories/stcp_repository.dart';

part 'stop_viewmodel.g.dart';

@riverpod
class StopViewModel extends _$StopViewModel {
  @override
  Future<List<Stop>> build() async {
    final repository = await ref.watch(stcpRepositoryProvider.future);
    return repository.getStops();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(stcpRepositoryProvider.future);
      return repository.getStops(forceRefresh: true);
    });
  }
}

@riverpod
Future<String> stopServiceId(Ref ref, Stop stop, DateTime? date) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopServiceId(stop, date);
}

@riverpod
Future<List<TransportRoute>> stopRoutes(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRoutes(stop);
}

@riverpod
Future<List<Schedule>> stopRouteSchedules(
  Ref ref,
  Stop stop,
  TransportRoute route,
  String serviceId,
) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRouteSchedules(stop, route, serviceId);
}

@riverpod
Future<List<Schedule>> stopSchedules(Ref ref, Stop stop) async {
  final serviceId = await ref.watch(stopServiceIdProvider(stop, null).future);
  final routes = await ref.watch(stopRoutesProvider(stop).future);

  final schedules = await Future.wait(
    routes.map(
      (route) =>
          ref.watch(stopRouteSchedulesProvider(stop, route, serviceId).future),
    ),
  );

  return schedules.expand((s) => s).toList()
    ..sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));
}

@riverpod
Future<List<Trip>> stopRealtimeTrips(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRealtimeTrips(stop);
}
