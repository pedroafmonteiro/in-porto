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

String _$stopSchedulesHash() => r'd91708a0b1dc946c01bf21ff90f139d8cf39266d';

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
          AsyncValue<(DateTime, List<Trip>)>,
          (DateTime, List<Trip>),
          FutureOr<(DateTime, List<Trip>)>
        >
    with
        $FutureModifier<(DateTime, List<Trip>)>,
        $FutureProvider<(DateTime, List<Trip>)> {
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
  $FutureProviderElement<(DateTime, List<Trip>)> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(DateTime, List<Trip>)> create(Ref ref) {
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

String _$stopRealtimeTripsHash() => r'87ccc2b263bdb4a0c0942e1a665a8d503dbcdd6f';

final class StopRealtimeTripsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<(DateTime, List<Trip>)>, Stop> {
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

@ProviderFor(stopDepartures)
final stopDeparturesProvider = StopDeparturesFamily._();

final class StopDeparturesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DepartureInfo>>,
          List<DepartureInfo>,
          FutureOr<List<DepartureInfo>>
        >
    with
        $FutureModifier<List<DepartureInfo>>,
        $FutureProvider<List<DepartureInfo>> {
  StopDeparturesProvider._({
    required StopDeparturesFamily super.from,
    required Stop super.argument,
  }) : super(
         retry: null,
         name: r'stopDeparturesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopDeparturesHash();

  @override
  String toString() {
    return r'stopDeparturesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DepartureInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DepartureInfo>> create(Ref ref) {
    final argument = this.argument as Stop;
    return stopDepartures(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StopDeparturesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopDeparturesHash() => r'666bd726d39d52e51face7cff2a5b7913ca1e1e6';

final class StopDeparturesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DepartureInfo>>, Stop> {
  StopDeparturesFamily._()
    : super(
        retry: null,
        name: r'stopDeparturesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopDeparturesProvider call(Stop stop) =>
      StopDeparturesProvider._(argument: stop, from: this);

  @override
  String toString() => r'stopDeparturesProvider';
}

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

@ProviderFor(filteredStopSchedules)
final filteredStopSchedulesProvider = FilteredStopSchedulesFamily._();

final class FilteredStopSchedulesProvider
    extends
        $FunctionalProvider<
          AsyncValue<({List<Schedule> future, List<Schedule> past})>,
          ({List<Schedule> future, List<Schedule> past}),
          FutureOr<({List<Schedule> future, List<Schedule> past})>
        >
    with
        $FutureModifier<({List<Schedule> future, List<Schedule> past})>,
        $FutureProvider<({List<Schedule> future, List<Schedule> past})> {
  FilteredStopSchedulesProvider._({
    required FilteredStopSchedulesFamily super.from,
    required ({Stop stop, DateTime date}) super.argument,
  }) : super(
         retry: null,
         name: r'filteredStopSchedulesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredStopSchedulesHash();

  @override
  String toString() {
    return r'filteredStopSchedulesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<({List<Schedule> future, List<Schedule> past})>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({List<Schedule> future, List<Schedule> past})> create(Ref ref) {
    final argument = this.argument as ({Stop stop, DateTime date});
    return filteredStopSchedules(ref, stop: argument.stop, date: argument.date);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredStopSchedulesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredStopSchedulesHash() =>
    r'e586609b43dd710fe14fbf935cb6060964051718';

final class FilteredStopSchedulesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<({List<Schedule> future, List<Schedule> past})>,
          ({Stop stop, DateTime date})
        > {
  FilteredStopSchedulesFamily._()
    : super(
        retry: null,
        name: r'filteredStopSchedulesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredStopSchedulesProvider call({
    required Stop stop,
    required DateTime date,
  }) => FilteredStopSchedulesProvider._(
    argument: (stop: stop, date: date),
    from: this,
  );

  @override
  String toString() => r'filteredStopSchedulesProvider';
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
