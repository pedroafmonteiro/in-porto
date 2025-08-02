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

  Trip copyWith({
    String? id,
    String? routeId,
    String? serviceId,
    String? headsign,
    String? shortName,
    int? directionId,
    String? blockId,
    String? shapeId,
    int? wheelchairAccessible,
    int? bikesAllowed,
    int? carsAllowed,
  }) {
    return Trip(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      serviceId: serviceId ?? this.serviceId,
      headsign: headsign ?? this.headsign,
      shortName: shortName ?? this.shortName,
      directionId: directionId ?? this.directionId,
      blockId: blockId ?? this.blockId,
      shapeId: shapeId ?? this.shapeId,
      wheelchairAccessible: wheelchairAccessible ?? this.wheelchairAccessible,
      bikesAllowed: bikesAllowed ?? this.bikesAllowed,
      carsAllowed: carsAllowed ?? this.carsAllowed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': id,
      'route_id': routeId,
      'service_id': serviceId,
      if (headsign != null) 'trip_headsign': headsign,
      if (shortName != null) 'trip_short_name': shortName,
      if (directionId != null) 'direction_id': directionId,
      if (blockId != null) 'block_id': blockId,
      if (shapeId != null) 'shape_id': shapeId,
      if (wheelchairAccessible != null)
        'wheelchair_accessible': wheelchairAccessible,
      if (bikesAllowed != null) 'bikes_allowed': bikesAllowed,
      if (carsAllowed != null) 'cars_allowed': carsAllowed,
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['trip_id'] as String,
      routeId: json['route_id'] as String,
      serviceId: json['service_id'] as String,
      headsign: json['trip_headsign'] as String?,
      shortName: json['trip_short_name'] as String?,
      directionId: json['direction_id'] is int
          ? json['direction_id'] as int
          : (json['direction_id'] != null
                ? int.tryParse(json['direction_id'].toString())
                : null),
      blockId: json['block_id'] as String?,
      shapeId: json['shape_id'] as String?,
      wheelchairAccessible: json['wheelchair_accessible'] is int
          ? json['wheelchair_accessible'] as int
          : (json['wheelchair_accessible'] != null
                ? int.tryParse(json['wheelchair_accessible'].toString())
                : null),
      bikesAllowed: json['bikes_allowed'] is int
          ? json['bikes_allowed'] as int
          : (json['bikes_allowed'] != null
                ? int.tryParse(json['bikes_allowed'].toString())
                : null),
      carsAllowed: json['cars_allowed'] is int
          ? json['cars_allowed'] as int
          : (json['cars_allowed'] != null
                ? int.tryParse(json['cars_allowed'].toString())
                : null),
    );
  }

  @override
  String toString() {
    return 'Trip(id: $id, routeId: $routeId, serviceId: $serviceId, headsign: $headsign, shortName: $shortName, directionId: $directionId, blockId: $blockId, shapeId: $shapeId, wheelchairAccessible: $wheelchairAccessible, bikesAllowed: $bikesAllowed, carsAllowed: $carsAllowed)';
  }
}
