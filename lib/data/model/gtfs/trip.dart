import 'package:objectbox/objectbox.dart';
import 'route.dart';
import 'calendar.dart';

@Entity()
class Trip {
  @Id()
  int id = 0;

  @Index()
  final String tripId;

  final String routeGtfsId;

  final String serviceId;

  final String? headsign;

  final String? shortName;

  final int? directionId;

  final String? blockId;

  final String? shapeId;

  final int? wheelchairAccessible;

  final int? bikesAllowed;

  final int? carsAllowed;

  final route = ToOne<Route>();
  final calendar = ToOne<Calendar>();

  Trip({
    this.id = 0,
    required this.tripId,
    required this.routeGtfsId,
    required this.serviceId,
    this.headsign,
    this.shortName,
    this.directionId,
    this.blockId,
    this.shapeId,
    this.wheelchairAccessible,
    this.bikesAllowed,
    this.carsAllowed,
  }) : assert(tripId.isNotEmpty, 'Trip id cannot be empty'),
       assert(routeGtfsId.isNotEmpty, 'Trip routeGtfsId cannot be empty'),
       assert(serviceId.isNotEmpty, 'Trip serviceId cannot be empty'),
       assert(
         directionId == null || directionId == 0 || directionId == 1,
         'directionId must be 0 or 1',
       ),
       assert(
         wheelchairAccessible == null ||
             (wheelchairAccessible >= 0 && wheelchairAccessible <= 2),
         'wheelchairAccessible must be 0, 1, or 2',
       ),
       assert(
         bikesAllowed == null || (bikesAllowed >= 0 && bikesAllowed <= 2),
         'bikesAllowed must be 0, 1, or 2',
       ),
       assert(
         carsAllowed == null || (carsAllowed >= 0 && carsAllowed <= 2),
         'carsAllowed must be 0, 1, or 2',
       );

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      tripId: map['trip_id']?.toString() ?? '',
      routeGtfsId: map['route_id']?.toString() ?? '',
      serviceId: map['service_id']?.toString() ?? '',
      headsign: map['trip_headsign']?.toString(),
      shortName: map['trip_short_name']?.toString(),
      directionId: int.tryParse(map['direction_id']?.toString() ?? ''),
      blockId: map['block_id']?.toString(),
      shapeId: map['shape_id']?.toString(),
      wheelchairAccessible: int.tryParse(
        map['wheelchair_accessible']?.toString() ?? '',
      ),
      bikesAllowed: int.tryParse(map['bikes_allowed']?.toString() ?? ''),
      carsAllowed: int.tryParse(map['cars_allowed']?.toString() ?? ''),
    );
  }

  @override
  String toString() {
    return 'Trip(tripId: $tripId, routeGtfsId: $routeGtfsId, serviceId: $serviceId, headsign: $headsign, shortName: $shortName, directionId: $directionId, blockId: $blockId, shapeId: $shapeId, wheelchairAccessible: $wheelchairAccessible, bikesAllowed: $bikesAllowed, carsAllowed: $carsAllowed)';
  }
}
