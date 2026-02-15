import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class RouteDetails extends ConsumerWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;
  final TransportRoute route;

  const RouteDetails({
    super.key,
    required this.onOpen,
    required this.onClose,
    required this.onSelected,
    required this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRouteShapes = ref.watch(routeShapeCoordinatesProvider(route));
    final totalMaxHeight = MediaQuery.of(context).size.height * 0.5;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: totalMaxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,
        children: [
          Text(
            'Route ${route.shortName} - ${route.longName}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Flexible(
            child: asyncRouteShapes.when(
              data: (shapes) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: shapes.length,
                itemBuilder: (context, index) {
                  final shape = shapes[index];
                  return ListTile(
                    title: Text(
                      'Shape ${shape.sequence}: (${shape.latitude}, ${shape.longitude})',
                    ),
                    subtitle: Text('Direction ID: ${shape.directionId}'),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
