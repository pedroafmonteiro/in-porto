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

String _$stopViewModelHash() => r'6343aca9b4b1763b7fa4e25a2648e4f2313ed9d0';

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

@ProviderFor(stopServiceId)
final stopServiceIdProvider = StopServiceIdFamily._();

final class StopServiceIdProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  StopServiceIdProvider._({
    required StopServiceIdFamily super.from,
    required (Stop, DateTime?) super.argument,
  }) : super(
         retry: null,
         name: r'stopServiceIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopServiceIdHash();

  @override
  String toString() {
    return r'stopServiceIdProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as (Stop, DateTime?);
    return stopServiceId(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is StopServiceIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopServiceIdHash() => r'd8a1da03a6e1061e6a7e590f1f2e549596c12588';

final class StopServiceIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, (Stop, DateTime?)> {
  StopServiceIdFamily._()
    : super(
        retry: null,
        name: r'stopServiceIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopServiceIdProvider call(Stop stop, DateTime? date) =>
      StopServiceIdProvider._(argument: (stop, date), from: this);

  @override
  String toString() => r'stopServiceIdProvider';
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

String _$stopRoutesHash() => r'357a83bae1768083645a617e9e269cc5ba33f47e';

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

@ProviderFor(stopRouteSchedules)
final stopRouteSchedulesProvider = StopRouteSchedulesFamily._();

final class StopRouteSchedulesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Schedule>>,
          List<Schedule>,
          FutureOr<List<Schedule>>
        >
    with $FutureModifier<List<Schedule>>, $FutureProvider<List<Schedule>> {
  StopRouteSchedulesProvider._({
    required StopRouteSchedulesFamily super.from,
    required (Stop, TransportRoute, String) super.argument,
  }) : super(
         retry: null,
         name: r'stopRouteSchedulesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopRouteSchedulesHash();

  @override
  String toString() {
    return r'stopRouteSchedulesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Schedule>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Schedule>> create(Ref ref) {
    final argument = this.argument as (Stop, TransportRoute, String);
    return stopRouteSchedules(ref, argument.$1, argument.$2, argument.$3);
  }

  @override
  bool operator ==(Object other) {
    return other is StopRouteSchedulesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopRouteSchedulesHash() =>
    r'31008b8c4fbc796672cedc77ef2c6d3d7f541b09';

final class StopRouteSchedulesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Schedule>>,
          (Stop, TransportRoute, String)
        > {
  StopRouteSchedulesFamily._()
    : super(
        retry: null,
        name: r'stopRouteSchedulesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopRouteSchedulesProvider call(
    Stop stop,
    TransportRoute route,
    String serviceId,
  ) => StopRouteSchedulesProvider._(
    argument: (stop, route, serviceId),
    from: this,
  );

  @override
  String toString() => r'stopRouteSchedulesProvider';
}

@ProviderFor(stopSchedules)
final stopSchedulesProvider = StopSchedulesFamily._();

final class StopSchedulesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Schedule>>,
          List<Schedule>,
          FutureOr<List<Schedule>>
        >
    with $FutureModifier<List<Schedule>>, $FutureProvider<List<Schedule>> {
  StopSchedulesProvider._({
    required StopSchedulesFamily super.from,
    required (Stop, DateTime?) super.argument,
  }) : super(
         retry: null,
         name: r'stopSchedulesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopSchedulesHash();

  @override
  String toString() {
    return r'stopSchedulesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Schedule>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Schedule>> create(Ref ref) {
    final argument = this.argument as (Stop, DateTime?);
    return stopSchedules(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is StopSchedulesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopSchedulesHash() => r'0de5c0c52dd7e959639ba8843fb169798bd01639';

final class StopSchedulesFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<Schedule>>, (Stop, DateTime?)> {
  StopSchedulesFamily._()
    : super(
        retry: null,
        name: r'stopSchedulesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopSchedulesProvider call(Stop stop, DateTime? date) =>
      StopSchedulesProvider._(argument: (stop, date), from: this);

  @override
  String toString() => r'stopSchedulesProvider';
}

@ProviderFor(stopRealtimeTrips)
final stopRealtimeTripsProvider = StopRealtimeTripsFamily._();

final class StopRealtimeTripsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  StopRealtimeTripsProvider._({
    required StopRealtimeTripsFamily super.from,
    required Stop super.argument,
  }) : super(
         retry: null,
         name: r'stopRealtimeTripsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopRealtimeTripsHash();

  @override
  String toString() {
    return r'stopRealtimeTripsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    final argument = this.argument as Stop;
    return stopRealtimeTrips(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StopRealtimeTripsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopRealtimeTripsHash() => r'3b9378a9f428e2f39c61a74b91169f75e1dc1698';

final class StopRealtimeTripsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Trip>>, Stop> {
  StopRealtimeTripsFamily._()
    : super(
        retry: null,
        name: r'stopRealtimeTripsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopRealtimeTripsProvider call(Stop stop) =>
      StopRealtimeTripsProvider._(argument: stop, from: this);

  @override
  String toString() => r'stopRealtimeTripsProvider';
}
