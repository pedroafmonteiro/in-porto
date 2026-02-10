import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapAnimationManager {
  final MapController mapController;
  final TickerProvider vsync;
  AnimationController? _animationController;

  MapAnimationManager({
    required this.mapController,
    required this.vsync,
  });

  void dispose() {
    _animationController?.dispose();
  }

  void moveTo(double latitude, double longitude, {bool animated = true}) {
    final camera = mapController.camera;
    final currentZoom = camera.zoom;
    final destZoom = currentZoom < 16 ? 16.0 : currentZoom;

    final zoomDiff = destZoom - currentZoom;
    final latSpanAtDest =
        (camera.visibleBounds.north - camera.visibleBounds.south) /
        math.pow(2, zoomDiff);

    final centerLat = latitude - (latSpanAtDest * 0.20);

    if (animated) {
      _animatedMapMove(LatLng(centerLat, longitude), destZoom);
    } else {
      mapController.move(LatLng(centerLat, longitude), destZoom);
    }
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    _animationController?.stop();
    _animationController?.dispose();

    final latTween = Tween<double>(
      begin: mapController.camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: mapController.camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: mapController.camera.zoom,
      end: destZoom,
    );

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );
    final animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    );

    _animationController!.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _animationController?.dispose();
        _animationController = null;
      }
    });

    _animationController!.forward();
  }
}
