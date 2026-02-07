import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopOverview extends ConsumerWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;
  final String stopId;
  final String stopName;

  const StopOverview({
    super.key,
    required this.onOpen,
    this.onClose,
    required this.onSelected,
    required this.stopId,
    required this.stopName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStop = ref.watch(stopDetailsProvider(stopId));
    final asyncTrips = ref.watch(stopRealtimeTripsProvider(stopId));

    return Column(
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
                        stopName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      asyncStop.when(
                        data: (stop) => stop.routes!.isNotEmpty
                            ? Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: stop.routes!.map((route) {
                                  return RouteBadge(
                                    number: route.number,
                                    color: route.color,
                                    textColor: route.textColor,
                                  );
                                }).toList(),
                              )
                            : Container(),
                        loading: () => Container(),
                        error: (e, st) => Text(
                          'Unable to load lines.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        asyncTrips.when(
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
                        children: [
                          RouteBadge(
                            number: trip.routeShortName,
                            color: trip.routeColor,
                            textColor: trip.routeTextColor,
                          ),
                          Text(
                            trip.headsign ?? 'Destination',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            trip.arrivalMinutes != null
                                ? '${trip.arrivalMinutes!.round()} min'
                                : 'N/A',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Text(
                  'No trips available.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
          loading: () => Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ExpressiveLoadingIndicator(),
          ),
          error: (e, st) {
            return Text(
              'Unable to load trips.',
              style: Theme.of(context).textTheme.bodySmall,
            );
          },
        ),
      ],
    );
  }
}
