import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/view/stops/widgets/departure_card.dart';
import 'package:in_porto/view/stops/utils/stop_scroll_physics.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/utils.dart';

class StopSchedulesList extends ConsumerWidget {
  const StopSchedulesList({
    super.key,
    required this.stop,
    required this.selectedRouteIds,
    required this.selectedDate,
    required this.showOlderDepartures,
    required this.scrollController,
    required this.onShowOlderDepartures,
  });

  final Stop stop;
  final Set<String> selectedRouteIds;
  final DateTime selectedDate;
  final bool showOlderDepartures;
  final ScrollController scrollController;
  final VoidCallback onShowOlderDepartures;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSchedules = ref.watch(
      filteredStopSchedulesProvider(
        stop: stop,
        date: selectedDate,
        selectedRouteIds: selectedRouteIds,
      ),
    );
    final asyncRoutes = ref.watch(stopRoutesProvider(stop));

    return asyncSchedules.maybeWhen(
      skipLoadingOnRefresh: true,
      data: (partitioned) => _buildContent(context, partitioned, asyncRoutes),
      loading: () {
        if (asyncSchedules.hasValue) {
          return _buildContent(context, asyncSchedules.value!, asyncRoutes);
        }
        return Center(
          child: ExpressiveLoadingIndicator(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
      orElse: () => _buildError(context),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ({List<dynamic> future, List<dynamic> past}) partitioned,
    AsyncValue<List<TransportRoute>> asyncRoutes,
  ) {
    final pastSchedules = partitioned.past;
    final futureSchedules = partitioned.future;
    final isToday = selectedDate.isToday();
    final hasOlder = isToday && pastSchedules.isNotEmpty && !showOlderDepartures;

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
        if (showOlderDepartures) ...[
          _buildSchedulesList(pastSchedules, routes, isToday, isPast: true),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 16.0,
              ),
              child: Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      AppLocalizations.of(context)!.upcomingDepartures,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
            ),
          ),
        ],
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
        _buildSchedulesList(
          futureSchedules,
          routes,
          isToday,
          isPast: false,
          key: const ValueKey('future_list_start'),
        ),
        if (isToday && futureSchedules.isEmpty) _buildNoMoreTrips(context),
      ],
    );
  }

  Widget _buildSchedulesList(
    List<dynamic> schedules,
    List<TransportRoute> routes,
    bool isToday, {
    required bool isPast,
    Key? key,
  }) {
    return SliverPadding(
      key: key,
      padding: EdgeInsets.only(
        top: isPast ? 16.0 : 0.0,
        bottom: isPast
            ? 0.0
            : (!isPast && isToday && schedules.isEmpty ? 0.0 : 92.0),
        left: 16.0,
        right: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final schedule = schedules[index];
            final route = routes.firstWhere(
              (r) => r.id == schedule.routeId,
              orElse: () => routes.first,
            );

            final departureTime = schedule.departureTime.toDateTime();

            final card = DepartureCard(
              departure: DepartureInfo(
                route: route,
                schedule: schedule,
                departureTime: departureTime ?? DateTime.now(),
                isRealtime: false,
              ),
              isToday: isToday,
            );

            if (isPast) {
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0.0, end: 0.6),
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Opacity(opacity: value, child: child),
                  );
                },
                child: card,
              );
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: card,
            );
          },
          childCount: schedules.length,
        ),
      ),
    );
  }

  Widget _buildNoMoreTrips(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: [
            const Icon(Icons.sentiment_dissatisfied_rounded, size: 64),
            Text(
              AppLocalizations.of(context)!.noMoreTripsToday,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.0,
        children: [
          const Icon(Icons.error_outline, size: 64),
          Text(
            AppLocalizations.of(context)!.errorLoadingTrips,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
