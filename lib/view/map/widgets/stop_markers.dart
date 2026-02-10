import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';

class StopMarkers extends ConsumerWidget {
  const StopMarkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stops = ref.watch(visibleStopsProvider);

    return MarkerLayer(
      markers: stops
          .map(
            (stop) => Marker(
              point: LatLng(stop.latitude!, stop.longitude!),
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(selectedNavigationOverrideProvider.notifier)
                      .select(stop);
                },
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
