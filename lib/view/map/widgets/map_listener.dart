import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/viewmodel/location_viewmodel.dart';
import 'package:in_porto/viewmodel/map_viewmodel.dart';
import 'package:in_porto/view/map/utils/map_animation_manager.dart';

class MapListener extends ConsumerWidget {
  final MapAnimationManager animationManager;

  const MapListener({
    super.key,
    required this.animationManager,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(selectedNavigationOverrideProvider, (previous, next) {
      if (next is Stop && next.latitude != null && next.longitude != null) {
        ref.read(mapStateControllerProvider.notifier).stopFollowing();
        animationManager.moveTo(next.latitude!, next.longitude!);
      }
    });

    ref.listen(userLocationProvider, (previous, next) {
      if (ref.read(mapStateControllerProvider).isFollowing && next.hasValue) {
        final pos = next.value!;
        animationManager.moveTo(pos.latitude, pos.longitude, animated: false);
      }
    });

    ref.listen(centerOnMarkerProvider, (previous, next) {
      if (next.counter > 0) {
        switch (next.target) {
          case MapCenterTarget.stop:
            final selected = ref.read(selectedNavigationOverrideProvider);
            if (selected is Stop &&
                selected.latitude != null &&
                selected.longitude != null) {
              ref.read(mapStateControllerProvider.notifier).stopFollowing();
              animationManager.moveTo(selected.latitude!, selected.longitude!);
            }
            break;
          case MapCenterTarget.user:
            ref.read(mapStateControllerProvider.notifier).startFollowing();
            final location = ref.read(userLocationProvider).value;
            if (location != null) {
              animationManager.moveTo(location.latitude, location.longitude);
            }
            break;
        }
      }
    });

    return const SizedBox.shrink();
  }
}
