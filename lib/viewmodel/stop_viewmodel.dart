import 'package:in_porto/model/departure_info.dart';
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
          departureTime: s.departureTime.normalizeTime(),
          headsign: s.headsign,
        );
      });
      allSchedules.addAll(lateYesterdayTrips);
    } catch (e) {
      // Ignore errors fetching yesterday's schedules
    }
  } else {
    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = targetDate.year == yesterday.year &&
        targetDate.month == yesterday.month &&
        targetDate.day == yesterday.day;
    if (isYesterday) {
      allSchedules.removeWhere((s) => s.departureTime.isLateNight());
    }
  }

  allSchedules.sort((a, b) => a.departureTime.compareTo(b.departureTime));

  return allSchedules;
}

@riverpod
Future<List<Trip>> stopRealtimeTrips(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRealtimeTrips(stop);
}

@riverpod
Future<List<DepartureInfo>> stopDepartures(Ref ref, Stop stop) async {
  final routes = await ref.watch(stopRoutesProvider(stop).future);
  final schedules = await ref.watch(stopSchedulesProvider(stop, null).future);
  final realtimeTrips = await ref.watch(stopRealtimeTripsProvider(stop).future);
  final now = ref.watch(nowProvider).asData?.value ?? DateTime.now();

  final nowString = now.toDisplayTime();
  final departures = <DepartureInfo>[];

  for (final route in routes) {
    final routeRealtime =
        realtimeTrips.where((t) => t.routeShortName == route.shortName).toList();

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
      final routeSchedules = schedules
          .where(
            (s) =>
                s.routeId == route.id &&
                s.departureTime.compareTo(nowString) >= 0,
          )
          .toList();

      final seenHeadsigns = <String>{};
      for (final schedule in routeSchedules) {
        if (seenHeadsigns.contains(schedule.headsign)) continue;
        seenHeadsigns.add(schedule.headsign ?? '');

        final departureTime = schedule.departureTime.toDateTime(now: now);

        if (departureTime != null) {
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
  }

  departures.sort((a, b) => a.departureTime.compareTo(b.departureTime));
  return departures;
}

@riverpod
Future<({List<Schedule> past, List<Schedule> future})> filteredStopSchedules(
  Ref ref, {
  required Stop stop,
  required DateTime date,
  required Set<String> selectedRouteIds,
}) async {
  final schedules = await ref.watch(stopSchedulesProvider(stop, date).future);

  final filteredSchedules = selectedRouteIds.isEmpty
      ? schedules
      : schedules.where((s) => selectedRouteIds.contains(s.routeId)).toList();

  final now = ref.watch(nowProvider).asData?.value ?? DateTime.now();
  final isToday = date.isToday();

  List<Schedule> pastSchedules = [];
  List<Schedule> futureSchedules = [];

  if (isToday) {
    final nowString = now.toDisplayTime();
    for (final s in filteredSchedules) {
      if (s.departureTime.compareTo(nowString) < 0) {
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