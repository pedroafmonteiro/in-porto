// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../state_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShowOlderDepartures)
final showOlderDeparturesProvider = ShowOlderDeparturesProvider._();

final class ShowOlderDeparturesProvider
    extends $NotifierProvider<ShowOlderDepartures, bool> {
  ShowOlderDeparturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showOlderDeparturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showOlderDeparturesHash();

  @$internal
  @override
  ShowOlderDepartures create() => ShowOlderDepartures();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showOlderDeparturesHash() =>
    r'd55951543c8871f41e22cf97e524defe3d0e45bc';

abstract class _$ShowOlderDepartures extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedRouteIds)
final selectedRouteIdsProvider = SelectedRouteIdsProvider._();

final class SelectedRouteIdsProvider
    extends $NotifierProvider<SelectedRouteIds, Set<String>> {
  SelectedRouteIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedRouteIdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedRouteIdsHash();

  @$internal
  @override
  SelectedRouteIds create() => SelectedRouteIds();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$selectedRouteIdsHash() => r'2b52a87a1f79a8da5824be40864361668f9550a6';

abstract class _$SelectedRouteIds extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(now)
final nowProvider = NowProvider._();

final class NowProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  NowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowHash();

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    return now(ref);
  }
}

String _$nowHash() => r'd2be8e4229a805ec4af53686e480000e63d4878e';
