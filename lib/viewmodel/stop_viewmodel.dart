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
Future<Stop> stopDetails(Ref ref, String stopId) async {
  final repository = await ref.read(stcpRepositoryProvider.future);
  return repository.fetchStopDetails(stopId);
}