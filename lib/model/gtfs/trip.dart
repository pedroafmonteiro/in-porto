class Trip {
  /// Identifies a trip (required)
  final String id;

  /// Identifies a route (required)
  final String routeId;

  /// Identifies a set of dates when service is available (required)
  final String serviceId;

  /// Text for signage (optional)
  final String? headsign;

  /// Public facing text to identify the trip (optional)
  final String? shortName;

  /// Direction of travel (optional, 0 or 1)
  final int? directionId;

  /// Block ID (optional)
  final String? blockId;

  /// Shape ID (conditionally required)
  final String? shapeId;

  /// Wheelchair accessibility (optional, 0-2)
  final int? wheelchairAccessible;

  /// Bikes allowed (optional, 0-2)
  final int? bikesAllowed;

  /// Cars allowed (optional, 0-2)
  final int? carsAllowed;

  Trip({
    required this.id,
    required this.routeId,
    required this.serviceId,
    this.headsign,
    this.shortName,
    this.directionId,
    this.blockId,
    this.shapeId,
    this.wheelchairAccessible,
    this.bikesAllowed,
    this.carsAllowed,
  }) : assert(id.isNotEmpty, 'Trip id cannot be empty'),
       assert(routeId.isNotEmpty, 'Trip routeId cannot be empty'),
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
      id: map['trip_id'] as String,
      routeId: map['route_id'] as String,
      serviceId: map['service_id'] as String,
      headsign: map['trip_headsign'] as String?,
      shortName: map['trip_short_name'] as String?,
      directionId: map['direction_id'] as int?,
      blockId: map['block_id'] as String?,
      shapeId: map['shape_id'] as String?,
      wheelchairAccessible: map['wheelchair_accessible'] as int?,
      bikesAllowed: map['bikes_allowed'] as int?,
      carsAllowed: map['cars_allowed'] as int?,
    );
  }

  @override
  String toString() {
    return 'Trip(id: $id, routeId: $routeId, serviceId: $serviceId, headsign: $headsign, shortName: $shortName, directionId: $directionId, blockId: $blockId, shapeId: $shapeId, wheelchairAccessible: $wheelchairAccessible, bikesAllowed: $bikesAllowed, carsAllowed: $carsAllowed)';
  }
}
