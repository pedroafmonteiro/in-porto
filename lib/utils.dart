import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';

extension DateTimeExtension on DateTime {
  String toDisplayTime() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  String formatRelativeTime(BuildContext context, {bool showRelative = true}) {
    if (!showRelative) return toDisplayTime();

    final now = DateTime.now();
    final difference = this.difference(now).inMinutes;

    if (difference < 0) return toDisplayTime();
    if (difference == 0) return AppLocalizations.of(context)!.now;
    if (difference < 60) return '$difference min';
    return toDisplayTime();
  }
}

extension TimeStringExtension on String {
  DateTime? toDateTime({DateTime? now}) {
    final isYesterday = startsWith('Y:');
    final rawTime = isYesterday ? substring(2) : this;

    final parts = rawTime.split(':').map((e) => int.tryParse(e) ?? 0).toList();
    if (parts.length < 2) return null;

    var reference = now ?? DateTime.now();
    if (isYesterday) {
      reference = reference.subtract(const Duration(days: 1));
    }

    final date = DateTime(reference.year, reference.month, reference.day);
    return date.add(
      Duration(
        hours: parts[0],
        minutes: parts[1],
        seconds: parts.length > 2 ? parts[2] : 0,
      ),
    );
  }

  String normalizeTime() {
    final rawTime = startsWith('Y:') ? substring(2) : this;
    final parts = rawTime.split(':');
    if (parts.isEmpty) return rawTime;
    final hour = (int.tryParse(parts[0]) ?? 0) % 24;
    return '${hour.toString().padLeft(2, '0')}:${parts.sublist(1).join(':')}';
  }

  bool isLateNight() {
    final rawTime = startsWith('Y:') ? substring(2) : this;
    return (int.tryParse(rawTime.split(':').first) ?? 0) >= 24;
  }
}

extension StringExtension on String? {
  String formatHeadsign() {
    if (this == null || this!.isEmpty) return 'Unknown Route';

    final text = this!.startsWith('*') ? this!.substring(1) : this!;
    return text.toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      final firstLetterIdx = word.indexOf(
        RegExp(r'[a-zà-ÿ]'),
      );
      if (firstLetterIdx == -1) return word;
      return word.replaceRange(
        firstLetterIdx,
        firstLetterIdx + 1,
        word[firstLetterIdx].toUpperCase(),
      );
    }).join(' ');
  }
}