import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/trip.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/repositories/stcp_repository.dart';

part 'stop_viewmodel.g.dart';

@riverpod
class StopViewModel extends _$StopViewModel {
  @override
  Future<List<Stop>> build() async {
    final repository = await ref.watch(stcpRepositoryProvider.future);
    return repository.getStops();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(stcpRepositoryProvider.future);
      return repository.getStops(forceRefresh: true);
    });
  }
}

@riverpod
Future<List<TransportRoute>> stopRoutes(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRoutes(stop);
}

@riverpod
Future<List<Trip>> stopRealtimeTrips(Ref ref, Stop stop) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopRealtimeTrips(stop);
}
