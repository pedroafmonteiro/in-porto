import 'dart:async';
import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/stops/utils/stop_utils.dart';
import 'package:in_porto/view/stops/widgets/departure_card.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopOverviewDepartures extends ConsumerStatefulWidget {
  const StopOverviewDepartures({
    super.key,
    required this.stop,
    required this.asyncRoutes,
    required this.asyncSchedules,
  });

  final Stop stop;
  final AsyncValue<List<TransportRoute>> asyncRoutes;
  final AsyncValue<List<Schedule>> asyncSchedules;

  @override
  ConsumerState<StopOverviewDepartures> createState() =>
      _StopOverviewDeparturesState();
}

class _StopOverviewDeparturesState
    extends ConsumerState<StopOverviewDepartures> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted) {
        setState(() {});
        ref.invalidate(stopRealtimeTripsProvider(widget.stop));
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncRoutes = widget.asyncRoutes;
    final asyncSchedules = widget.asyncSchedules;
    final asyncRealtime = ref.watch(stopRealtimeTripsProvider(widget.stop));
    final now = DateTime.now();

    if ((asyncRoutes.isLoading && !asyncRoutes.hasValue) ||
        (asyncSchedules.isLoading && !asyncSchedules.hasValue)) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        alignment: Alignment.center,
        child: ExpressiveLoadingIndicator(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
    }

    if (asyncRoutes.hasError || asyncSchedules.hasError) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 8),
            Text(
              'Unable to load trips.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    }

    final routes = asyncRoutes.value ?? [];
    final schedules = asyncSchedules.value ?? [];
    final realtimeTrips = asyncRealtime.value ?? [];

    final nowString =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final departures = <DepartureInfo>[];

    for (final route in routes) {
      final routeRealtime = realtimeTrips
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

          final departureTime = StopUtils.parseToDateTime(
            schedule.departureTime,
            now: now,
          );

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

    if (departures.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, size: 48),
            const SizedBox(height: 8),
            Text(
              'No upcoming trips.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: 8.0,
      children: departures.map((info) {
        return DepartureCard(
          departure: info,
        );
      }).toList(),
    );
  }
}
