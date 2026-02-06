import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/view/map/map_view.dart';
import 'package:in_porto/view/navigation/navigation_mapper.dart';
import 'package:in_porto/view/navigation/widgets/action_center.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';

class NavigationView extends ConsumerWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOverride = ref.watch(selectedNavigationOverrideProvider);
    final override = selectedOverride.buildActionCenterOverride();

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: ActionCenter(
        overrideContent: override,
        onCloseOverride: () =>
            ref.read(selectedNavigationOverrideProvider.notifier).clear(),
      ),
      body: const MapView(),
    );
  }
}
