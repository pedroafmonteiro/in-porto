import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/repositories/repository_providers.dart';
import 'package:in_porto/utils.dart';
import 'package:in_porto/viewmodel/state_viewmodel.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/schedule_viewmodel.g.dart';

@riverpod
Future<String> stopServiceId(Ref ref, Stop stop, DateTime? date) async {
  final repository = await ref.read(transportAgencyRepositoryProvider.future);
  return repository.fetchStopServiceId(stop, date);
}

@riverpod
Future<List<Schedule>> stopRouteSchedules(
  Ref ref,
  Stop stop,
  TransportRoute route,
  String serviceId,
) async {
  final repository = await ref.read(transportAgencyRepositoryProvider.future);
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
