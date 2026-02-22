import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_viewmodel.g.dart';

@riverpod
class ShowOlderDepartures extends _$ShowOlderDepartures {
  @override
  bool build() => false;

  void toggle(bool value) => state = value;
}

@riverpod
class SelectedRouteIds extends _$SelectedRouteIds {
  @override
  Set<String> build() => {};

  void toggle(String id) {
    final newState = Set<String>.from(state);
    if (newState.contains(id)) {
      newState.remove(id);
    } else {
      newState.add(id);
    }
    state = newState;
  }

  void clear() => state = {};
}

@riverpod
Stream<DateTime> now(Ref ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(
    const Duration(seconds: 15),
    (_) => DateTime.now(),
  );
}
