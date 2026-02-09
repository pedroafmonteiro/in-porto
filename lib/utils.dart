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
    final parts = split(':').map((e) => int.tryParse(e) ?? 0).toList();
    if (parts.length < 2) return null;

    final reference = now ?? DateTime.now();
    return DateTime(reference.year, reference.month, reference.day).add(
      Duration(
        hours: parts[0],
        minutes: parts[1],
        seconds: parts.length > 2 ? parts[2] : 0,
      ),
    );
  }

  String normalizeTime() {
    final parts = split(':');
    if (parts.isEmpty) return this;
    final hour = (int.tryParse(parts[0]) ?? 0) % 24;
    return '${hour.toString().padLeft(2, '0')}:${parts.sublist(1).join(':')}';
  }

  bool isLateNight() => (int.tryParse(split(':').first) ?? 0) >= 24;
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
