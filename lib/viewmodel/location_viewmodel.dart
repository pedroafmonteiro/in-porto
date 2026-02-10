import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_viewmodel.g.dart';

@riverpod
class LocationController extends _$LocationController {
  @override
  FutureOr<LocationPermission> build() async {
    return await Geolocator.checkPermission();
  }

  Future<void> requestPermission() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final permission = await Geolocator.requestPermission();
      return permission;
    });
  }

  Future<void> updatePermission() async {
    state = await AsyncValue.guard(() async {
      return await Geolocator.checkPermission();
    });
  }
}

@riverpod
Stream<Position> userLocation(Ref ref) async* {
  final permission = ref.watch(locationControllerProvider).value;

  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
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
