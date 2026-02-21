import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/utils.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class DepartureCard extends ConsumerWidget {
  const DepartureCard({
    super.key,
    required this.departure,
    this.isToday = true,
  });

  final DepartureInfo departure;
  final bool isToday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final now = ref.watch(nowProvider).asData?.value ?? DateTime.now();
    final isPast = departure.departureTime.isBefore(now);
    final title =
        departure.headsignOverride ??
        departure.schedule?.headsign ??
        l10n.unknownRoute;

    return GestureDetector(
      onTap: () => ref
          .read(selectedNavigationOverrideProvider.notifier)
          .select(departure.route),
      child: Card(
        elevation: 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          leading: RouteBadge(
            number: departure.route.shortName,
            color: departure.route.color,
            textColor: departure.route.textColor,
          ),
          title: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: _buildTrailing(context, l10n, now, isPast),
        ),
      ),
    );
  }

  Widget _buildTrailing(
    BuildContext context,
    AppLocalizations l10n,
    DateTime now,
    bool isPast,
  ) {
    if (departure.isRealtime) {
      final (color, label) = switch (departure.status) {
        'ON_TIME' => (Colors.green, l10n.onTime),
        'DELAYED' => (Colors.orange, l10n.delayed),
        'ARRIVING' => (Colors.green, l10n.arriving),
        _ => (null, null),
      };

      final timeText =
          departure.realtimeMinutes != null &&
              departure.realtimeMinutes!.round() > 0
          ? '${departure.realtimeMinutes!.round()} min'
          : l10n.now;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          if (label != null)
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
              ),
            ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          departure.departureTime.formatRelativeTime(
            context,
            showRelative: isToday,
          ),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (!isPast) Text(l10n.scheduled),
      ],
    );
  }
}
