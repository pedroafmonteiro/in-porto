// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../schedule_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$stopServiceIdHash() => r'2295fece69081e81e5ff67721ae4c4539081adc8';

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
    r'85ceb5e455d17b2268ece2089a8f975f15a0e1de';

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

String _$stopSchedulesHash() => r'f714d8ec587fb29e8870ad5428f5c391aca9210a';

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
