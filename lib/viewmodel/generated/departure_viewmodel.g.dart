// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../departure_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$stopRealtimeTripsHash() => r'0652a0f27faecf82330abc3cc6fa1bcad2944c41';

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
