import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/routes/widgets/route_stop_card.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class RouteDetailsStops extends ConsumerWidget {
  final TransportRoute route;

  const RouteDetailsStops({super.key, required this.route});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRouteStops = ref.watch(routeStopsProvider(route));
    return asyncRouteStops.maybeWhen(
      data: (stops) {
        final sortedStops = List<Stop>.from(stops)
          ..sort((a, b) => (a.sequence ?? 0).compareTo(b.sequence ?? 0));
        return Column(
          spacing: 8.0,
          children: sortedStops
              .map(
                (stop) => RouteStopCard(
                  stop: stop,
                  isFirst: stop == sortedStops.first,
                  isLast: stop == sortedStops.last,
                ),
              )
              .toList(),
        );
      },
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
