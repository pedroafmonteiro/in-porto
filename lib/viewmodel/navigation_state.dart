import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/navigation.dart';

class SelectedNavigationOverrideNotifier extends Notifier<NavigationOverride?> {
  final List<NavigationOverride> _history = [];

  @override
  NavigationOverride? build() => null;

  void select(NavigationOverride? override, {bool delayed = false}) async {
    if (delayed) {
      await Future.delayed(const Duration(milliseconds: 550));
    }

    if (override == null) {
      _history.clear();
      state = null;
    } else {
      if (state != null) {
        _history.add(state!);
      }
      state = override;
    }
  }

  void pop() {
    if (_history.isNotEmpty) {
      state = _history.removeLast();
    } else {
      state = null;
    }
  }

  void clear() {
    _history.clear();
    state = null;
  }
}

final selectedNavigationOverrideProvider =
    NotifierProvider<SelectedNavigationOverrideNotifier, NavigationOverride?>(
      SelectedNavigationOverrideNotifier.new,
    );
