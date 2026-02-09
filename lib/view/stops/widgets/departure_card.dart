import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/departure_info.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/view/stops/utils/stop_utils.dart';

class DepartureCard extends StatelessWidget {
  const DepartureCard({
    super.key,
    required this.departure,
    this.isToday = true,
  });

  final DepartureInfo departure;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final title =
        departure.headsignOverride ??
        departure.schedule?.headsign ??
        AppLocalizations.of(context)!.unknownRoute;

    Widget trailing;
    if (departure.isRealtime) {
      trailing = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          switch (departure.status) {
            'ON_TIME' => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  departure.realtimeMinutes != null &&
                          departure.realtimeMinutes!.round() > 0
                      ? '${departure.realtimeMinutes!.round()} min'
                      : AppLocalizations.of(context)!.now,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.onTime,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            'DELAYED' => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  departure.realtimeMinutes != null &&
                          departure.realtimeMinutes!.round() > 0
                      ? '${departure.realtimeMinutes!.round()} min'
                      : AppLocalizations.of(context)!.now,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.delayed,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            'ARRIVING' => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  departure.realtimeMinutes != null &&
                          departure.realtimeMinutes!.round() > 0
                      ? '${departure.realtimeMinutes!.round()} min'
                      : AppLocalizations.of(context)!.now,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.arriving,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            _ => Text(
              departure.realtimeMinutes != null &&
                      departure.realtimeMinutes!.round() > 0
                  ? '${departure.realtimeMinutes!.round()} min'
                  : AppLocalizations.of(context)!.now,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          },
        ],
      );
    } else {
      trailing = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            StopUtils.formatDepartureTime(
              departure.schedule?.departureTime,
              isToday: isToday,
              context: context,
            ),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(AppLocalizations.of(context)!.scheduled),
        ],
      );
    }

    return Card(
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
        trailing: trailing,
      ),
    );
  }
}
