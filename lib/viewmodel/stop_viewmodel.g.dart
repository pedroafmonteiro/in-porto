// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StopViewModel)
final stopViewModelProvider = StopViewModelProvider._();

final class StopViewModelProvider
    extends $AsyncNotifierProvider<StopViewModel, List<Stop>> {
  StopViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stopViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stopViewModelHash();

  @$internal
  @override
  StopViewModel create() => StopViewModel();
}

String _$stopViewModelHash() => r'c4891857e37b1a66942d9429efb4af47ea41b488';

abstract class _$StopViewModel extends $AsyncNotifier<List<Stop>> {
  FutureOr<List<Stop>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Stop>>, List<Stop>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Stop>>, List<Stop>>,
              AsyncValue<List<Stop>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(stopRoutes)
final stopRoutesProvider = StopRoutesFamily._();

final class StopRoutesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TransportRoute>>,
          List<TransportRoute>,
          FutureOr<List<TransportRoute>>
        >
    with
        $FutureModifier<List<TransportRoute>>,
        $FutureProvider<List<TransportRoute>> {
  StopRoutesProvider._({
    required StopRoutesFamily super.from,
    required Stop super.argument,
  }) : super(
         retry: null,
         name: r'stopRoutesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopRoutesHash();

  @override
  String toString() {
    return r'stopRoutesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TransportRoute>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TransportRoute>> create(Ref ref) {
    final argument = this.argument as Stop;
    return stopRoutes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StopRoutesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopRoutesHash() => r'a9e4204aceb6a6a8b90ac53e01b96ea33ba47763';

final class StopRoutesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TransportRoute>>, Stop> {
  StopRoutesFamily._()
    : super(
        retry: null,
        name: r'stopRoutesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopRoutesProvider call(Stop stop) =>
      StopRoutesProvider._(argument: stop, from: this);

  @override
  String toString() => r'stopRoutesProvider';
}
