import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/view/stops/utils/stop_utils.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.route,
    this.isToday = true,
  });

  final Schedule schedule;
  final TransportRoute? route;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: RouteBadge(
          number: route!.shortName,
          color: route!.color,
          textColor: route!.textColor,
        ),
        title: Text(
          schedule.headsign ?? 'Unknown Route',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              StopUtils.formatDepartureTime(
                schedule.departureTime,
                isToday: isToday,
                context: context,
              ),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(AppLocalizations.of(context)!.scheduled),
          ],
        ),
      ),
    );
  }
}
