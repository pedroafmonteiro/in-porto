import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_porto/view/navigation/widgets/action_center.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ActionCenter(),
      body: GoogleMap(
        tiltGesturesEnabled: false,
        buildingsEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.14961, -8.61099),
          zoom: 12,
        ),
      ),
    );
  }
}
