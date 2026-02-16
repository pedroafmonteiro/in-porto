import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';

class RouteStopCard extends ConsumerWidget {
  const RouteStopCard({
    super.key,
    required this.stop,
    required this.isFirst,
    required this.isLast,
  });

  final Stop stop;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.1,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        onTap: () =>
            ref.read(selectedNavigationOverrideProvider.notifier).select(stop),
        leading: SizedBox(
          width: 24,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              if (!isFirst)
                Positioned(
                  top: -26,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              if (!isLast)
                Positioned(
                  top: 0,
                  bottom: -26,
                  child: Container(
                    width: 2,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              Container(
                width: (isFirst || isLast) ? 16 : 12,
                height: (isFirst || isLast) ? 16 : 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          stop.name ?? 'Unknown Stop',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
