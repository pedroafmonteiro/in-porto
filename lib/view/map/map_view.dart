import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:in_porto/viewmodel/location_viewmodel.dart';
import 'package:latlong2/latlong.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';
import 'package:in_porto/view/map/widgets/stop_markers.dart';
import 'package:in_porto/view/map/widgets/user_location_marker.dart';
import 'package:in_porto/view/map/widgets/route_polylines.dart';
import 'package:in_porto/view/map/widgets/map_listener.dart';
import 'package:in_porto/view/map/utils/map_animation_manager.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView>
    with TickerProviderStateMixin {
  final MapController _controller = MapController();
  late final MapAnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = MapAnimationManager(
      mapController: _controller,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationManager.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncUserLocation = ref.watch(userLocationProvider);
    final userLocation = asyncUserLocation.whenData((data) => data).value;

    return Stack(
      children: [
        FlutterMap(
          mapController: _controller,
          options: MapOptions(
            initialCenter: userLocation != null
                ? LatLng(userLocation.latitude, userLocation.longitude)
                : const LatLng(41.14961, -8.61099),
            initialZoom: 12,
            minZoom: 10,
            maxZoom: 18,
            onTap: (tapPosition, point) {
              ref.read(selectedNavigationOverrideProvider.notifier).clear();
            },
            onMapEvent: ref
                .read(mapStateControllerProvider.notifier)
                .handleMapEvent,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://basemaps.cartocdn.com/${Theme.of(context).brightness == Brightness.dark ? 'dark_all' : 'light_all'}/{z}/{x}/{y}{r}.png',
              userAgentPackageName: 'pt.pedroafmonteiro.in_porto',
              tileProvider: NetworkTileProvider(
                cachingProvider:
                    BuiltInMapCachingProvider.getOrCreateInstance(),
              ),
            ),
            const RoutePolylines(),
            const StopMarkers(),
            const UserLocationMarker(),
          ],
        ),
        MapListener(animationManager: _animationManager),
      ],
    );
  }
}
