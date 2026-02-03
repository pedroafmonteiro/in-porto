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

String _$stopViewModelHash() => r'79bb825af4fd766a677ad705498dc253a9bfe3a7';

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

@ProviderFor(stopDetails)
final stopDetailsProvider = StopDetailsFamily._();

final class StopDetailsProvider
    extends $FunctionalProvider<AsyncValue<Stop>, Stop, FutureOr<Stop>>
    with $FutureModifier<Stop>, $FutureProvider<Stop> {
  StopDetailsProvider._({
    required StopDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'stopDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopDetailsHash();

  @override
  String toString() {
    return r'stopDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Stop> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Stop> create(Ref ref) {
    final argument = this.argument as String;
    return stopDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StopDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopDetailsHash() => r'c48def1affcb5bd1933e861e399140ee5bcf31cc';

final class StopDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Stop>, String> {
  StopDetailsFamily._()
    : super(
        retry: null,
        name: r'stopDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopDetailsProvider call(String stopId) =>
      StopDetailsProvider._(argument: stopId, from: this);

  @override
  String toString() => r'stopDetailsProvider';
}
