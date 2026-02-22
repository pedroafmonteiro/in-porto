// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RouteViewModel)
final routeViewModelProvider = RouteViewModelProvider._();

final class RouteViewModelProvider
    extends $AsyncNotifierProvider<RouteViewModel, List<TransportRoute>> {
  RouteViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeViewModelHash();

  @$internal
  @override
  RouteViewModel create() => RouteViewModel();
}

String _$routeViewModelHash() => r'd75ef10cf46703a360d7366559922fc8fc5101ce';

abstract class _$RouteViewModel extends $AsyncNotifier<List<TransportRoute>> {
  FutureOr<List<TransportRoute>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TransportRoute>>, List<TransportRoute>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransportRoute>>,
                List<TransportRoute>
              >,
              AsyncValue<List<TransportRoute>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(routeShapeCoordinates)
final routeShapeCoordinatesProvider = RouteShapeCoordinatesFamily._();

final class RouteShapeCoordinatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ShapeCoordinates>>,
          List<ShapeCoordinates>,
          FutureOr<List<ShapeCoordinates>>
        >
    with
        $FutureModifier<List<ShapeCoordinates>>,
        $FutureProvider<List<ShapeCoordinates>> {
  RouteShapeCoordinatesProvider._({
    required RouteShapeCoordinatesFamily super.from,
    required TransportRoute super.argument,
  }) : super(
         retry: null,
         name: r'routeShapeCoordinatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeShapeCoordinatesHash();

  @override
  String toString() {
    return r'routeShapeCoordinatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ShapeCoordinates>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ShapeCoordinates>> create(Ref ref) {
    final argument = this.argument as TransportRoute;
    return routeShapeCoordinates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteShapeCoordinatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeShapeCoordinatesHash() =>
    r'd38300cb8bfe6da4cec7afbd16a53c5a4fe1e2f7';

final class RouteShapeCoordinatesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ShapeCoordinates>>,
          TransportRoute
        > {
  RouteShapeCoordinatesFamily._()
    : super(
        retry: null,
        name: r'routeShapeCoordinatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteShapeCoordinatesProvider call(TransportRoute route) =>
      RouteShapeCoordinatesProvider._(argument: route, from: this);

  @override
  String toString() => r'routeShapeCoordinatesProvider';
}

@ProviderFor(routeStops)
final routeStopsProvider = RouteStopsFamily._();

final class RouteStopsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Stop>>,
          List<Stop>,
          FutureOr<List<Stop>>
        >
    with $FutureModifier<List<Stop>>, $FutureProvider<List<Stop>> {
  RouteStopsProvider._({
    required RouteStopsFamily super.from,
    required TransportRoute super.argument,
  }) : super(
         retry: null,
         name: r'routeStopsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeStopsHash();

  @override
  String toString() {
    return r'routeStopsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Stop>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Stop>> create(Ref ref) {
    final argument = this.argument as TransportRoute;
    return routeStops(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteStopsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeStopsHash() => r'36e38be63d8eec0667b3f6a63b177bbcc220bf48';

final class RouteStopsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Stop>>, TransportRoute> {
  RouteStopsFamily._()
    : super(
        retry: null,
        name: r'routeStopsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteStopsProvider call(TransportRoute route) =>
      RouteStopsProvider._(argument: route, from: this);

  @override
  String toString() => r'routeStopsProvider';
}

@ProviderFor(routeInverse)
final routeInverseProvider = RouteInverseFamily._();

final class RouteInverseProvider
    extends
        $FunctionalProvider<
          AsyncValue<TransportRoute?>,
          TransportRoute?,
          FutureOr<TransportRoute?>
        >
    with $FutureModifier<TransportRoute?>, $FutureProvider<TransportRoute?> {
  RouteInverseProvider._({
    required RouteInverseFamily super.from,
    required TransportRoute super.argument,
  }) : super(
         retry: null,
         name: r'routeInverseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeInverseHash();

  @override
  String toString() {
    return r'routeInverseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TransportRoute?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TransportRoute?> create(Ref ref) {
    final argument = this.argument as TransportRoute;
    return routeInverse(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteInverseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeInverseHash() => r'42d7a881bb738f775dd4cf8e5f26deff24a797c5';

final class RouteInverseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TransportRoute?>, TransportRoute> {
  RouteInverseFamily._()
    : super(
        retry: null,
        name: r'routeInverseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteInverseProvider call(TransportRoute route) =>
      RouteInverseProvider._(argument: route, from: this);

  @override
  String toString() => r'routeInverseProvider';
}
