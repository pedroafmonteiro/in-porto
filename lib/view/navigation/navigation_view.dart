import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_porto/view/navigation/widgets/action_center.dart';
import 'package:in_porto/view/navigation/constants/map_style.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  GoogleMapController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!mounted) return;
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const ActionCenter(),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        style: mapStyle,
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
      ),
    );
  }
}
