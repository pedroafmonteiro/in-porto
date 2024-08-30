import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../notifiers/location_notifier.dart';
import 'package:in_porto/values.dart';

class MapWidget extends StatefulWidget {
  final LocationNotifier locationNotifier;

  const MapWidget({super.key, required this.locationNotifier});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final LatLng _center = const LatLng(41.1585561, -8.6125248);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GoogleMap(
        onMapCreated: (controller) {
          widget.locationNotifier.locationService?.onMapCreated(controller);
        },
        style: Theme.of(context).brightness == Brightness.dark
            ? googleMapsDark
            : googleMapsLight,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.025,
        ),
        myLocationEnabled: (widget.locationNotifier.locationStatus == 4) ? true : false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        rotateGesturesEnabled: false,
      ),
    );
  }
}