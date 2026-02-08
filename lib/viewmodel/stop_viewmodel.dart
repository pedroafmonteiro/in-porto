import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/trip.dart';
import 'package:in_porto/utils.dart';
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
Future<List<Schedule>> stopSchedules(Ref ref, Stop stop, DateTime? date) async {
  final now = DateTime.now();
  final targetDate = date ?? now;
  final isToday =
      targetDate.year == now.year &&
      targetDate.month == now.month &&
      targetDate.day == now.day;

  final routes = await ref.watch(stopRoutesProvider(stop).future);

  Future<List<Schedule>> fetchSchedulesForDate(DateTime d) async {
    final serviceId = await ref.watch(stopServiceIdProvider(stop, d).future);
    final schedules = await Future.wait(
      routes.map(
        (route) => ref.watch(
          stopRouteSchedulesProvider(stop, route, serviceId).future,
        ),
      ),
    );
    return schedules.expand((s) => s).toList();
  }

  final allSchedules = await fetchSchedulesForDate(targetDate);

  if (isToday) {
    final yesterday = targetDate.subtract(const Duration(days: 1));
    try {
      final yesterdaySchedules = await fetchSchedulesForDate(yesterday);
      final lateYesterdayTrips = yesterdaySchedules
          .where((s) => TimeUtils.isLateNight(s.arrivalTime))
          .map((s) {
            return Schedule(
              stopId: s.stopId,
              routeId: s.routeId,
              directionId: s.directionId,
              serviceId: s.serviceId,
              arrivalTime: TimeUtils.normalizeTime(s.arrivalTime),
            );
          });
      allSchedules.addAll(lateYesterdayTrips);
    } catch (e) {
      // Ignore errors fetching yesterday's schedules
    }
  }

  allSchedules.sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));

  return allSchedules;
}

@riverpod
Future<List<Trip>> stopRealtimeTrips(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRealtimeTrips(stop);
}
