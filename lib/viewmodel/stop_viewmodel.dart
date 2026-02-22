import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stop_viewmodel.g.dart';

@riverpod
class StopViewModel extends _$StopViewModel {
  @override
  Future<List<Stop>> build() async {
    final repository = await ref.watch(
      transportAgencyRepositoryProvider.future,
    );
    return repository.getStops();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(
        transportAgencyRepositoryProvider.future,
      );
      return repository.getStops(forceRefresh: true);
    });
  }
}

@riverpod
Future<List<TransportRoute>> stopRoutes(Ref ref, Stop stop) async {
  final repository = await ref.read(transportAgencyRepositoryProvider.future);
  final allRoutes = await repository.getRoutes();
  final filteredRoutes = allRoutes.where((route) => route.stopIds.contains(stop.id)).toList();
  filteredRoutes.sort((a, b) => a.color?.compareTo(b.color ?? '') ?? 0);
  return filteredRoutes;
}
