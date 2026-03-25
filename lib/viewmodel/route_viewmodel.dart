import 'package:collection/collection.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/shape_coordinates.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/repositories/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/route_viewmodel.g.dart';

@riverpod
class RouteViewModel extends _$RouteViewModel {
  @override
  Future<List<TransportRoute>> build() async {
    final repository = await ref.watch(
      transportAgencyRepositoryProvider.future,
    );
    return repository.getRoutes();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = await ref.read(
        transportAgencyRepositoryProvider.future,
      );
      return repository.getRoutes(forceRefresh: true);
    });
  }
}

@riverpod
Future<List<ShapeCoordinates>> routeShapeCoordinates(
  Ref ref,
  TransportRoute route,
) async {
  final repository = await ref.read(transportAgencyRepositoryProvider.future);
  return repository.fetchRouteShapeCoordinates(route);
}

@riverpod
Future<List<Stop>> routeStops(Ref ref, TransportRoute route) async {
  final repository = await ref.read(transportAgencyRepositoryProvider.future);
  return repository.fetchRouteStops(route);
}

@riverpod
Future<TransportRoute?> routeInverse(Ref ref, TransportRoute route) async {
  final allRoutes = await ref.watch(routeViewModelProvider.future);
  return allRoutes.firstWhereOrNull(
    (TransportRoute r) =>
        r.id == route.id && r.directionId != route.directionId,
  );
}
