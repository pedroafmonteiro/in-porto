import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class RouteDetailsHeader extends ConsumerWidget {
  const RouteDetailsHeader({super.key, required this.route});

  final TransportRoute route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeInverse = ref.watch(routeInverseProvider(route)).asData?.value;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              spacing: 8.0,
              children: [
                RouteBadge(
                  number: route.shortName,
                  color: route.color,
                  textColor: route.textColor,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => ref
                        .read(centerOnMarkerProvider.notifier)
                        .trigger(MapCenterTarget.route),
                    child: Text(
                      route.tripHeadsign?.toUpperCase() ?? 'Unknown Route',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Visibility(
                  visible: routeInverse != null,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: IconButton(
                    onPressed: routeInverse != null
                        ? () => ref
                              .read(selectedNavigationOverrideProvider.notifier)
                              .select(routeInverse)
                        : null,
                    icon: const Icon(Icons.swap_horiz_rounded),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
