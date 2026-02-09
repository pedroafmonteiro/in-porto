import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopOverview extends ConsumerWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;
  final Stop stop;

  const StopOverview({
    super.key,
    required this.onOpen,
    this.onClose,
    required this.onSelected,
    required this.stop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoutes = ref.watch(stopRoutesProvider(stop));
    final asyncRealtime = ref.watch(stopRealtimeTripsProvider(stop));

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: onOpen,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stop.name ?? 'Unknown Stop',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        asyncRoutes.when(
                          data: (routes) => routes.isNotEmpty
                              ? Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: routes.map((route) {
                                    return RouteBadge(
                                      number: route.shortName,
                                      color: route.color,
                                      textColor: route.textColor,
                                    );
                                  }).toList(),
                                )
                              : Container(),
                          loading: () => Container(),
                          error: (e, st) => Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          asyncRealtime.when(
            data: (trips) => trips.isNotEmpty
                ? Column(
                    spacing: 8.0,
                    children: trips.map((trip) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 8.0,
                          children: [
                            RouteBadge(
                              number: trip.routeShortName,
                              color: trip.routeColor,
                              textColor: trip.routeTextColor,
                            ),
                            Expanded(
                              child: Text(
                                trip.headsign ?? 'Destination',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              trip.arrivalMinutes != null
                                  ? '${trip.arrivalMinutes!.round()} min'
                                  : 'N/A',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, size: 48),
                        const SizedBox(height: 8),
                        Text(
                          'No upcoming trips.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
            loading: () => Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ExpressiveLoadingIndicator(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            error: (e, st) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      'Unable to load trips.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
