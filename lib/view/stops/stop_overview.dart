import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopOverview extends ConsumerWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;
  final String stopId;
  final String stopName;

  const StopOverview({
    super.key,
    required this.onOpen,
    this.onClose,
    required this.onSelected,
    required this.stopId,
    required this.stopName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStop = ref.watch(stopDetailsProvider(stopId));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: onOpen,
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stopName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  asyncStop.when(
                    data: (stop) => stop.routes!.isNotEmpty
                        ? Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: stop.routes!.map((route) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(
                                      int.parse(
                                        '0xff${route.color?.replaceFirst('#', '') ?? 'ffffff'}',
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    route.number ?? 'Line',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Color(
                                            int.parse(
                                              '0xff${route.textColor?.replaceFirst('#', '') ?? '000000'}',
                                            ),
                                          ),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Text(
                            'No lines available.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, st) => Text(
                      'Unable to load lines.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
