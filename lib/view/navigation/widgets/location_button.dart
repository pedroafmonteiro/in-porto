import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_porto/viewmodel/location_viewmodel.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';

class LocationButton extends ConsumerWidget {
  const LocationButton({super.key});

  Future<void> _handleLocationAction(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(locationControllerProvider.notifier);
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission Denied'),
            content: const Text(
              'This app needs location permission to show your position on the map. Please try again.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission Denied Forever'),
            content: const Text(
              'Location permission is permanently denied. Please enable it in your device settings to use this feature.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Geolocator.openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }
    }

    await controller.updatePermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      ref.read(mapStateControllerProvider.notifier).startFollowing();
      ref.read(centerOnMarkerProvider.notifier).trigger(MapCenterTarget.user);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(locationControllerProvider);
    final isFollowing =
        ref.watch(mapStateControllerProvider.select((s) => s.isFollowing));

    final IconData locationIcon = permissionAsync.when(
      data: (permission) =>
          (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always)
          ? Icons.my_location
          : Icons.location_searching,
      loading: () => Icons.location_searching,
      error: (_, _) => Icons.location_disabled,
    );

    return FloatingActionButton(
      onPressed: () => _handleLocationAction(context, ref),
      child: Icon(
        locationIcon,
        color: isFollowing ? Colors.blue : null,
      ),
    );
  }
}
