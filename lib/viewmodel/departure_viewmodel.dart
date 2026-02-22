import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/entities/trip.dart';
import 'package:in_porto/model/repositories/repository_providers.dart';
import 'package:in_porto/utils.dart';
import 'package:in_porto/viewmodel/schedule_viewmodel.dart';
import 'package:in_porto/viewmodel/state_viewmodel.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'departure_viewmodel.g.dart';

@riverpod
Future<(DateTime, List<Trip>)> stopRealtimeTrips(Ref ref, Stop stop) async {
  final repository = await ref.read(transportAgencyRepositoryProvider.future);
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
