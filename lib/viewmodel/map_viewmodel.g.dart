// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CenterOnMarker)
final centerOnMarkerProvider = CenterOnMarkerProvider._();

final class CenterOnMarkerProvider
    extends
        $NotifierProvider<
          CenterOnMarker,
          ({int counter, MapCenterTarget target})
        > {
  CenterOnMarkerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'centerOnMarkerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$centerOnMarkerHash();

  @$internal
  @override
  CenterOnMarker create() => CenterOnMarker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({int counter, MapCenterTarget target}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({int counter, MapCenterTarget target})>(value),
    );
  }
}

String _$centerOnMarkerHash() => r'9a4ce1989300df479a764d719697d75bfcde8303';

abstract class _$CenterOnMarker
    extends $Notifier<({int counter, MapCenterTarget target})> {
  ({int counter, MapCenterTarget target}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({int counter, MapCenterTarget target}),
              ({int counter, MapCenterTarget target})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({int counter, MapCenterTarget target}),
                ({int counter, MapCenterTarget target})
              >,
              ({int counter, MapCenterTarget target}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(MapStateController)
final mapStateControllerProvider = MapStateControllerProvider._();

final class MapStateControllerProvider
    extends $NotifierProvider<MapStateController, MapStateData> {
  MapStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapStateControllerHash();

  @$internal
  @override
  MapStateController create() => MapStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapStateData>(value),
    );
  }
}

String _$mapStateControllerHash() =>
    r'b1b7acc4167675e698f65bd00b3bbc5395930769';

abstract class _$MapStateController extends $Notifier<MapStateData> {
  MapStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MapStateData, MapStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapStateData, MapStateData>,
              MapStateData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(visibleStops)
final visibleStopsProvider = VisibleStopsProvider._();

final class VisibleStopsProvider
    extends $FunctionalProvider<List<Stop>, List<Stop>, List<Stop>>
    with $Provider<List<Stop>> {
  VisibleStopsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visibleStopsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visibleStopsHash();

  @$internal
  @override
  $ProviderElement<List<Stop>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Stop> create(Ref ref) {
    return visibleStops(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Stop> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Stop>>(value),
    );
  }
}

String _$visibleStopsHash() => r'9be44546f596951abd18d736e65d57aaac60f06e';
