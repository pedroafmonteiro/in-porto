import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/navigation.dart';

class SelectedNavigationOverrideNotifier extends Notifier<NavigationOverride?> {
  @override
  NavigationOverride? build() => null;

  void select(NavigationOverride? override, {bool delayed = false}) async {
    if (delayed) {
      await Future.delayed(const Duration(milliseconds: 550));
    }
    state = override;
  }

  void clear() {
    state = null;
  }
}

final selectedNavigationOverrideProvider =
    NotifierProvider<SelectedNavigationOverrideNotifier, NavigationOverride?>(
      SelectedNavigationOverrideNotifier.new,
    );
