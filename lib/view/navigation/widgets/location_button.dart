import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_porto/viewmodel/location_viewmodel.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';
import 'package:in_porto/view/navigation/utils/location_dialog_utils.dart';

class LocationButton extends ConsumerWidget {
  const LocationButton({super.key});

  Future<void> _handleLocationAction(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final controller = ref.read(locationControllerProvider.notifier);
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          final result = await LocationDialogUtils.showPermissionDenied(
            context,
          );
          if (result == LocationDialogResult.tryAgain) {
            permission = await Geolocator.requestPermission();

            if (permission != LocationPermission.whileInUse &&
                permission != LocationPermission.always &&
                context.mounted) {
              final settingsResult =
                  await LocationDialogUtils.showPermissionPermanentlyDenied(
                    context,
                  );
              if (settingsResult == LocationDialogResult.openSettings) {
                await Geolocator.openAppSettings();
              }
            }
          }
        }
        if (permission == LocationPermission.denied) {
          await controller.updatePermission();
          return;
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        final result =
            await LocationDialogUtils.showPermissionPermanentlyDenied(context);
        if (result == LocationDialogResult.openSettings) {
          await Geolocator.openAppSettings();
        }
      }
      await controller.updatePermission();
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      var accuracy = await Geolocator.getLocationAccuracy();

      if (accuracy == LocationAccuracyStatus.reduced) {
        if (context.mounted) {
          final result =
              await LocationDialogUtils.showPreciseLocationExplanation(context);
          if (result == LocationDialogResult.grant) {
            await Geolocator.requestPermission();
            accuracy = await Geolocator.getLocationAccuracy();

            if (accuracy == LocationAccuracyStatus.reduced && context.mounted) {
              final settingsResult =
                  await LocationDialogUtils.showPermissionPermanentlyDenied(
                    context,
                  );
              if (settingsResult == LocationDialogResult.openSettings) {
                await Geolocator.openAppSettings();
              }
            }
          }
        }
      }

      if (accuracy == LocationAccuracyStatus.precise) {
        ref.read(mapStateControllerProvider.notifier).startFollowing();
        ref.read(centerOnMarkerProvider.notifier).trigger(MapCenterTarget.user);
      }
    }

    await controller.updatePermission();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationStateAsync = ref.watch(locationControllerProvider);
    final isFollowing = ref.watch(
      mapStateControllerProvider.select((s) => s.isFollowing),
    );

    final IconData locationIcon = locationStateAsync.when(
      data: (state) =>
          (state.permission == LocationPermission.whileInUse ||
                  state.permission == LocationPermission.always) &&
              state.accuracy == LocationAccuracyStatus.precise
          ? Icons.my_location
          : Icons.location_searching,
      loading: () => Icons.location_searching,
      error: (_, _) => Icons.location_disabled,
    );

    return FloatingActionButton(
      onPressed: () => _handleLocationAction(context, ref),
      child: Icon(
        locationIcon,
        color: isFollowing && (locationIcon == Icons.my_location)
            ? Colors.blue
            : null,
      ),
    );
  }
}
