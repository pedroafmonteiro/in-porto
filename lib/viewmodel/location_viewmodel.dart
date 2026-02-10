import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_viewmodel.g.dart';

typedef LocationState = ({
  LocationPermission permission,
  LocationAccuracyStatus accuracy,
});

@riverpod
class LocationController extends _$LocationController {
  @override
  FutureOr<LocationState> build() async {
    final permission = await Geolocator.checkPermission();
    final accuracy = await Geolocator.getLocationAccuracy();
    return (permission: permission, accuracy: accuracy);
  }

  Future<void> requestPermission() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final permission = await Geolocator.requestPermission();
      final accuracy = await Geolocator.getLocationAccuracy();
      return (permission: permission, accuracy: accuracy);
    });
  }

  Future<void> updatePermission() async {
    state = await AsyncValue.guard(() async {
      final permission = await Geolocator.checkPermission();
      final accuracy = await Geolocator.getLocationAccuracy();
      return (permission: permission, accuracy: accuracy);
    });
  }
}

@riverpod
Stream<Position> userLocation(Ref ref) async* {
  final locationState = ref.watch(locationControllerProvider).value;

  if (locationState != null &&
      (locationState.permission == LocationPermission.whileInUse ||
          locationState.permission == LocationPermission.always) &&
      locationState.accuracy == LocationAccuracyStatus.precise) {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    yield* Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }
}
