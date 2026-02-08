import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DatePickerBadge extends StatelessWidget {
  const DatePickerBadge({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    this.icon = const Icon(Icons.calendar_today, size: 14),
    this.firstDate,
    this.lastDate,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final Widget icon;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final dates = List<DateTime>.generate(
      9,
      (i) => today.subtract(Duration(days: 1 - i)),
    );

    String getLabel(DateTime date) {
      if (date == today) {
        return AppLocalizations.of(context)!.today;
      }
      if (date == today.subtract(const Duration(days: 1))) {
        return AppLocalizations.of(context)!.yesterday;
      }
      if (date == today.add(const Duration(days: 1))) {
        return AppLocalizations.of(context)!.tomorrow;
      }
      return DateFormat('EEE, MMM d').format(date);
    }

    return Material(
      elevation: 0.05,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: InkWell(
          onTap: () async {
            final initialIndex = dates.indexWhere(
              (d) =>
                  d.year == selected.year &&
                  d.month == selected.month &&
                  d.day == selected.day,
            );
            int currentIndex = initialIndex != -1 ? initialIndex : 1;

            await showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 8.0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.selectDate,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: FixedExtentScrollController(
                            initialItem: currentIndex,
                          ),
                          onSelectedItemChanged: (index) {
                            currentIndex = index;
                          },
                          selectionOverlay: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withValues(
                                    alpha: 0.05,
                                  ),
                            ),
                          ),
                          children: dates.map((date) {
                            return Center(
                              child: Text(
                                getLabel(date),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          bottom: 4.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                onDateChanged(dates[currentIndex]);
                                Navigator.of(context).pop();
                              },
                              child: Text(AppLocalizations.of(context)!.done),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 4),
              Text(
                getLabel(selected),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
