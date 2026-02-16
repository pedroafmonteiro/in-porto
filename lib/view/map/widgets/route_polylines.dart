import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/utils.dart';

class RoutePolylines extends ConsumerWidget {
  const RoutePolylines({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shapes = ref.watch(visibleShapesProvider);
    final selectedNavigation = ref.watch(selectedNavigationOverrideProvider);

    if (shapes.isEmpty || selectedNavigation is! TransportRoute) {
      return const SizedBox.shrink();
    }

    final points = shapes
        .where((s) => s.latitude != null && s.longitude != null)
        .map((s) => LatLng(s.latitude!, s.longitude!))
        .toList();

    if (points.isEmpty) return const SizedBox.shrink();

    final routeColor = selectedNavigation.color?.toColor() ?? Colors.blue;

    return PolylineLayer(
      polylines: [
        Polyline(
          points: points,
          strokeWidth: 4.0,
          color: routeColor,
        ),
      ],
    );
  }
}
