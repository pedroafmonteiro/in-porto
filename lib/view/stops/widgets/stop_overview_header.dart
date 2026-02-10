import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';

class StopOverviewHeader extends ConsumerWidget {
  const StopOverviewHeader({
    super.key,
    required this.stop,
    required this.asyncRoutes,
    required this.onOpen,
  });

  final Stop stop;
  final List<TransportRoute> asyncRoutes;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => ref
                        .read(centerOnMarkerProvider.notifier)
                        .trigger(MapCenterTarget.stop),
                    borderRadius: BorderRadius.circular(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.0,
                      children: [
                        Text(
                          stop.name ?? 'Unknown Stop',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AnimatedCrossFade(
                          firstChild: const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                          secondChild: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: asyncRoutes.map((route) {
                              return RouteBadge(
                                number: route.shortName,
                                color: route.color,
                                textColor: route.textColor,
                              );
                            }).toList(),
                          ),
                          crossFadeState: asyncRoutes.isNotEmpty
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 100),
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onOpen,
                  icon: const Icon(Icons.calendar_month_rounded),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
