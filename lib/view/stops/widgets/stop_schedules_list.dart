import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/view/stops/utils/stop_utils.dart';
import 'package:in_porto/view/stops/widgets/departure_card.dart';
import 'package:in_porto/view/stops/utils/stop_scroll_physics.dart';

class StopSchedulesList extends StatelessWidget {
  const StopSchedulesList({
    super.key,
    required this.asyncSchedules,
    required this.asyncRoutes,
    required this.selectedRouteIds,
    required this.selectedDate,
    required this.showOlderDepartures,
    required this.scrollController,
    required this.onShowOlderDepartures,
  });

  final AsyncValue<List<Schedule>> asyncSchedules;
  final AsyncValue<List<TransportRoute>> asyncRoutes;
  final Set<String> selectedRouteIds;
  final DateTime selectedDate;
  final bool showOlderDepartures;
  final ScrollController scrollController;
  final VoidCallback onShowOlderDepartures;

  @override
  Widget build(BuildContext context) {
    return asyncSchedules.when(
      data: (schedules) {
        final filteredSchedules = selectedRouteIds.isEmpty
            ? schedules
            : schedules
                  .where((s) => selectedRouteIds.contains(s.routeId))
                  .toList();

        final now = DateTime.now();
        final isToday =
            selectedDate.year == now.year &&
            selectedDate.month == now.month &&
            selectedDate.day == now.day;

        List<Schedule> pastSchedules = [];
        List<Schedule> futureSchedules = [];

        if (isToday) {
          final nowString =
              '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
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

        final hasOlder =
            isToday && pastSchedules.isNotEmpty && !showOlderDepartures;

        if (futureSchedules.isEmpty && pastSchedules.isEmpty && !hasOlder) {
          return Center(
            child: Text(AppLocalizations.of(context)!.noTripsFound),
          );
        }

        final routes = asyncRoutes.value ?? [];

        return CustomScrollView(
          controller: scrollController,
          physics: StopScrollPhysics(
            parent: const AlwaysScrollableScrollPhysics(),
            snapAtOrigin: !showOlderDepartures,
          ),
          center: const ValueKey('future_list_start'),
          slivers: [
            if (showOlderDepartures)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final schedule = pastSchedules[index];
                      final route = routes.isEmpty
                          ? null
                          : routes.firstWhere(
                              (r) => r.id == schedule.routeId,
                              orElse: () => routes.first,
                            );

                      if (route == null) return const SizedBox.shrink();

                      final departureTime = StopUtils.parseToDateTime(
                        schedule.departureTime,
                        now: now,
                      );

                      return TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        tween: Tween(begin: 0.0, end: 0.6),
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: DepartureCard(
                          departure: DepartureInfo(
                            route: route,
                            schedule: schedule,
                            departureTime: departureTime ?? now,
                            isRealtime: false,
                          ),
                          isToday: isToday,
                        ),
                      );
                    },
                    childCount: pastSchedules.length,
                  ),
                ),
              ),
            if (hasOlder)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 64.0,
                  child: Center(
                    child: TextButton.icon(
                      onPressed: onShowOlderDepartures,
                      icon: const Icon(Icons.history_rounded),
                      label: Text(
                        AppLocalizations.of(context)!.olderDepartures,
                      ),
                    ),
                  ),
                ),
              ),
            SliverPadding(
              key: const ValueKey('future_list_start'),
              padding: EdgeInsets.only(
                bottom: isToday && futureSchedules.isEmpty ? 0.0 : 92.0,
                left: 16.0,
                right: 16.0,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final schedule = futureSchedules[index];
                    final route = routes.isEmpty
                        ? null
                        : routes.firstWhere(
                            (r) => r.id == schedule.routeId,
                            orElse: () => routes.first,
                          );

                    if (route == null) return const SizedBox.shrink();

                    final departureTime = StopUtils.parseToDateTime(
                      schedule.departureTime,
                      now: now,
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DepartureCard(
                        departure: DepartureInfo(
                          route: route,
                          schedule: schedule,
                          departureTime: departureTime ?? now,
                          isRealtime: false,
                        ),
                        isToday: isToday,
                      ),
                    );
                  },
                  childCount: futureSchedules.length,
                ),
              ),
            ),
            if (isToday && futureSchedules.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.0,
                    children: [
                      const Icon(
                        Icons.sentiment_dissatisfied_rounded,
                        size: 64,
                      ),
                      Text(
                        AppLocalizations.of(context)!.noMoreTripsToday,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
      loading: () => Center(
        child: ExpressiveLoadingIndicator(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
            ),
            Text(
              AppLocalizations.of(context)!.errorLoadingTrips,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
