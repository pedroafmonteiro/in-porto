import 'package:in_porto/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:in_porto/utils.dart';

class StopUtils {
  static String formatArrivalTime(
    String? arrivalTime, {
    bool isToday = true,
    required BuildContext context,
  }) {
    if (arrivalTime == null || arrivalTime.isEmpty) return 'N/A';

    final initialHour = int.tryParse(arrivalTime.split(':').first) ?? 0;
    var time = TimeUtils.normalizeTime(arrivalTime);
    int addedDays = initialHour >= 24 ? 1 : 0;

    if (!isToday) {
      if (time.length >= 5) {
        return time.substring(0, 5);
      }
      return time;
    }

    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final arrivalDateTime = DateTime.parse(
        '${today.toIso8601String().split('T')[0]}T$time',
      ).add(Duration(days: addedDays));
      final difference = arrivalDateTime.difference(now).inMinutes;

      if (difference < 0) {
        final result = arrivalDateTime.toString().substring(11, 16);
        return result;
      } else if (difference == 0) {
        return AppLocalizations.of(context)!.now;
      } else if (difference < 60) {
        final result = '$difference min';
        return result;
      } else {
        final result = arrivalDateTime.toString().substring(11, 16);
        return result;
      }
    } catch (e) {
      return 'N/A';
    }
  }
}
