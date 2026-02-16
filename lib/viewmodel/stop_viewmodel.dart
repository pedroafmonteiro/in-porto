import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/shape_coordinates.dart';
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
class RouteViewModel extends _$RouteViewModel {
  @override
  Future<List<TransportRoute>> build() async {
    final repository = await ref.watch(stcpRepositoryProvider.future);
    return repository.getRoutes();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(stcpRepositoryProvider.future);
      return repository.getRoutes(forceRefresh: true);
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
  final isToday = targetDate.isToday();

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
  final today = DateTime(now.year, now.month, now.day);
  final isPast = targetDate.isBefore(today);

  if (isPast) {
    allSchedules.removeWhere((s) => s.departureTime.isLateNight());
  }

  if (isToday) {
    final yesterday = targetDate.subtract(const Duration(days: 1));
    try {
      final yesterdaySchedules = await fetchSchedulesForDate(yesterday);
      final lateYesterdayTrips = yesterdaySchedules
          .where((s) => s.departureTime.isLateNight())
          .map((s) {
            return Schedule(
              stopId: s.stopId,
              routeId: s.routeId,
              directionId: s.directionId,
              serviceId: s.serviceId,
              departureTime: 'Y:${s.departureTime}',
              headsign: s.headsign,
            );
          });
      allSchedules.addAll(lateYesterdayTrips);
    } catch (e) {
      // Ignore errors fetching yesterday's schedules
    }
  }

  allSchedules.sort((a, b) {
    final aTime = a.departureTime.toDateTime(now: targetDate);
    final bTime = b.departureTime.toDateTime(now: targetDate);
    if (aTime == null || bTime == null) {
      return a.departureTime.compareTo(b.departureTime);
    }
    return aTime.compareTo(bTime);
  });

  return allSchedules;
}

@riverpod
Future<(DateTime, List<Trip>)> stopRealtimeTrips(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRealtimeTrips(stop);
}

@riverpod
Future<List<DepartureInfo>> stopDepartures(Ref ref, Stop stop) async {
  final routes = await ref.watch(stopRoutesProvider(stop).future);
  final schedules = await ref.watch(stopSchedulesProvider(stop, null).future);
  final realtimeTrips = await ref.watch(stopRealtimeTripsProvider(stop).future);
  final now = ref.watch(nowProvider).asData?.value ?? DateTime.now();

  final departures = <DepartureInfo>[];

  for (final route in routes) {
    final routeRealtime = realtimeTrips.$2
        .where((t) => t.routeShortName == route.shortName)
        .toList();

    if (routeRealtime.isNotEmpty) {
      for (final trip in routeRealtime) {
        final minutes = trip.arrivalMinutes ?? 0;
        departures.add(
          DepartureInfo(
            route: route,
            schedule: null,
            departureTime: now.add(Duration(minutes: minutes.round())),
            isRealtime: true,
            realtimeMinutes: minutes,
            headsignOverride: trip.headsign,
            status: trip.status,
          ),
        );
      }
    } else {
      final seenHeadsigns = <String>{};
      for (final schedule in schedules) {
        if (schedule.routeId != route.id) continue;

        final departureTime = schedule.departureTime.toDateTime(now: now);
        if (departureTime == null || !departureTime.isAfter(now)) continue;

        if (seenHeadsigns.contains(schedule.headsign)) continue;
        seenHeadsigns.add(schedule.headsign ?? '');

        departures.add(
          DepartureInfo(
            route: route,
            schedule: schedule,
            departureTime: departureTime,
            isRealtime: false,
          ),
        );
      }
    }
  }

  departures.sort((a, b) => a.departureTime.compareTo(b.departureTime));
  return departures;
}

@riverpod
class ShowOlderDepartures extends _$ShowOlderDepartures {
  @override
  bool build() => false;

  void toggle(bool value) => state = value;
}

@riverpod
class SelectedRouteIds extends _$SelectedRouteIds {
  @override
  Set<String> build() => {};

  void toggle(String id) {
    final newState = Set<String>.from(state);
    if (newState.contains(id)) {
      newState.remove(id);
    } else {
      newState.add(id);
    }
    state = newState;
  }

  void clear() => state = {};
}

@riverpod
Future<({List<Schedule> past, List<Schedule> future})> filteredStopSchedules(
  Ref ref, {
  required Stop stop,
  required DateTime date,
}) async {
  final schedules = await ref.watch(stopSchedulesProvider(stop, date).future);
  final selectedRouteIds = ref.watch(selectedRouteIdsProvider);

  final filteredSchedules = selectedRouteIds.isEmpty
      ? schedules
      : schedules.where((s) => selectedRouteIds.contains(s.routeId)).toList();

  final now = ref.watch(nowProvider).asData?.value ?? DateTime.now();
  final isToday = date.isToday();

  List<Schedule> pastSchedules = [];
  List<Schedule> futureSchedules = [];

  if (isToday) {
    for (final s in filteredSchedules) {
      final departureDateTime = s.departureTime.toDateTime(now: date);
      if (departureDateTime == null) continue;

      if (departureDateTime.isBefore(now)) {
        pastSchedules.add(s);
      } else {
        futureSchedules.add(s);
      }
    }
    pastSchedules = pastSchedules.reversed.toList();
  } else {
    futureSchedules = filteredSchedules;
  }

  return (past: pastSchedules, future: futureSchedules);
}

@riverpod
Stream<DateTime> now(Ref ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(
    const Duration(seconds: 15),
    (_) => DateTime.now(),
  );
}

@riverpod
Future<List<ShapeCoordinates>> routeShapeCoordinates(
  Ref ref,
  TransportRoute route,
) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchRouteShapeCoordinates(route);
}

@riverpod
Future<List<Stop>> routeStops(Ref ref, TransportRoute route) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchRouteStops(route);
}
