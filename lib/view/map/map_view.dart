import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  final MapController _controller = MapController();
  LatLngBounds? _currentBounds;
  LatLngBounds? _previousBounds;
  double _currentZoom = 12;
  double _previousZoom = 12;
  final double _minZoomToShowStops = 16;
  List<Marker> _markers = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMapEvent(MapEvent event) {
    setState(() {
      _currentZoom = _controller.camera.zoom;
      _currentBounds = _controller.camera.visibleBounds;
    });
  }

  void _animateToStop(Stop stop) {
    if (stop.latitude == null || stop.longitude == null) {
      return;
    }

    final currentZoom = _controller.camera.zoom;
    _controller.move(
      LatLng(stop.latitude!, stop.longitude!),
      currentZoom < 16 ? 16 : currentZoom,
    );
  }

  void _updateMarkers(List<Stop> stops) {
    final shouldRecalculate =
        _currentBounds != _previousBounds ||
        _currentZoom != _previousZoom ||
        _markers.isEmpty;

    if (shouldRecalculate) {
      _markers = stops
          .where(
            (stop) =>
                _currentBounds != null &&
                stop.latitude != null &&
                stop.longitude != null &&
                _currentBounds!.contains(LatLng(stop.latitude!, stop.longitude!)) &&
                _currentZoom >= _minZoomToShowStops,
          )
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
          .toList();

      _previousBounds = _currentBounds;
      _previousZoom = _currentZoom;
    }
  }

  Widget _buildFlutterMap() {
    return FlutterMap(
      mapController: _controller,
      options: MapOptions(
        initialCenter: const LatLng(41.14961, -8.61099),
        initialZoom: 12,
        minZoom: 10,
        maxZoom: 18,
        onTap: (tapPosition, point) {
          ref.read(selectedNavigationOverrideProvider.notifier).clear();
        },
        onMapEvent: _onMapEvent,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'pt.pedroafmonteiro.in_porto',
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedNavigationOverrideProvider, (previous, next) {
      if (next is Stop) {
        _animateToStop(next);
      }
    });

    final stopsAsync = ref.watch(stopViewModelProvider);

    return stopsAsync.when(
      data: (stops) {
        _updateMarkers(stops);
        return _buildFlutterMap();
      },
      loading: () => _buildFlutterMap(),
      error: (error, stack) => _buildFlutterMap(),
    );
  }
}