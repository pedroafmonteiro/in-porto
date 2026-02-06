import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  GoogleMapController? _controller;
  LatLngBounds? _currentBounds;
  LatLngBounds? _previousBounds;
  double _currentZoom = 12;
  double _previousZoom = 12;
  final double _minZoomToShowStops = 16;
  Set<Marker> _markers = {};

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!mounted) return;
    _controller = controller;
  }

  void _onCameraMove(CameraPosition position) async {
    _currentZoom = position.zoom;

    if (_controller == null) return;

    try {
      final bounds = await _controller!.getVisibleRegion();
      setState(() {
        _currentBounds = bounds;
      });
    } catch (e) {
      // error getting bounds
    }
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
                stop.latitude! >= _currentBounds!.southwest.latitude &&
                stop.latitude! <= _currentBounds!.northeast.latitude &&
                stop.longitude! >= _currentBounds!.southwest.longitude &&
                stop.longitude! <= _currentBounds!.northeast.longitude &&
                _currentZoom >= _minZoomToShowStops,
          )
          .map(
            (stop) => Marker(
              markerId: MarkerId(stop.id),
              position: LatLng(stop.latitude!, stop.longitude!),
              onTap: () {
                ref
                    .read(selectedNavigationOverrideProvider.notifier)
                    .select(stop);
              },
            ),
          )
          .toSet();

      _previousBounds = _currentBounds;
      _previousZoom = _currentZoom;
    }
  }

  GoogleMap _buildGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      onTap: (LatLng latlng) {
        ref.read(selectedNavigationOverrideProvider.notifier).clear();
      },
      markers: _markers,
      tiltGesturesEnabled: false,
      buildingsEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      trafficEnabled: false,
      minMaxZoomPreference: const MinMaxZoomPreference(10.0, 18.0),
      initialCameraPosition: const CameraPosition(
        target: LatLng(41.14961, -8.61099),
        zoom: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stopsAsync = ref.watch(stopViewModelProvider);

    return stopsAsync.when(
      data: (stops) {
        _updateMarkers(stops);
        return _buildGoogleMap();
      },
      loading: () => _buildGoogleMap(),
      error: (error, stack) => _buildGoogleMap(),
    );
  }
}
