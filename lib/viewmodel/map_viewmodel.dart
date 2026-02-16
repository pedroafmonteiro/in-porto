import 'package:flutter_map/flutter_map.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/shape_coordinates.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

part 'map_viewmodel.g.dart';

enum MapCenterTarget {
  user,
  stop,
  route,
}

@riverpod
class CenterOnMarker extends _$CenterOnMarker {
  @override
  ({MapCenterTarget target, int counter}) build() =>
      (target: MapCenterTarget.user, counter: 0);

  void trigger(MapCenterTarget target) {
    state = (target: target, counter: state.counter + 1);
  }
}

typedef MapStateData = ({LatLngBounds? bounds, double zoom, bool isFollowing});

@riverpod
class MapStateController extends _$MapStateController {
  @override
  MapStateData build() {
    return (bounds: null, zoom: 12.0, isFollowing: true);
  }

  void handleMapEvent(MapEvent event) {
    if (!ref.mounted) return;

    final isUserGesture =
        event.source == MapEventSource.dragStart ||
        event.source == MapEventSource.onDrag ||
        event.source == MapEventSource.multiFingerGestureStart ||
        event.source == MapEventSource.onMultiFinger ||
        event.source == MapEventSource.scrollWheel ||
        event.source == MapEventSource.doubleTap ||
        event.source == MapEventSource.doubleTapHold;

    final nextFollowing = isUserGesture ? false : state.isFollowing;

    state = (
      bounds: event.camera.visibleBounds,
      zoom: event.camera.zoom,
      isFollowing: nextFollowing,
    );
  }

  void startFollowing() {
    state = (bounds: state.bounds, zoom: state.zoom, isFollowing: true);
  }

  void stopFollowing() {
    state = (bounds: state.bounds, zoom: state.zoom, isFollowing: false);
  }
}

@riverpod
List<Stop> visibleStops(Ref ref) {
  final stopsAsync = ref.watch(stopViewModelProvider);
  final mapState = ref.watch(mapStateControllerProvider);
  const minZoomToShowStops = 16.0;

  return stopsAsync.maybeWhen(
    data: (stops) {
      final bounds = mapState.bounds;
      if (bounds == null || mapState.zoom < minZoomToShowStops) {
        return [];
      }

      return stops
          .where(
            (stop) =>
                stop.latitude != null &&
                stop.longitude != null &&
                bounds.contains(LatLng(stop.latitude!, stop.longitude!)),
          )
          .toList();
    },
    orElse: () => [],
  );
}

@riverpod
List<ShapeCoordinates> visibleShapes(Ref ref) {
  final navigation = ref.watch(selectedNavigationOverrideProvider);
  if (navigation is! TransportRoute) return [];

  final shapesAsync = ref.watch(routeShapeCoordinatesProvider(navigation));

  return shapesAsync.maybeWhen(
    data: (shapes) {
      final sortedShapes = List<ShapeCoordinates>.from(shapes)
        ..sort((a, b) => (a.sequence ?? 0).compareTo(b.sequence ?? 0));
      return sortedShapes;
    },
    orElse: () => [],
  );
}
