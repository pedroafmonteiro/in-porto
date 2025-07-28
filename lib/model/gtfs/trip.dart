class Trip {
  final String id;
  final String routeId;
  final String serviceId;
  final String? headsign;
  final String? shortName;
  final int? directionId;
  final String? blockId;
  final String? shapeId;

  Trip({
    required this.id,
    required this.routeId,
    required this.serviceId,
    this.headsign,
    this.shortName,
    this.directionId,
    this.blockId,
    this.shapeId,
  });

  Trip copyWith({
    String? id,
    String? routeId,
    String? serviceId,
    String? headsign,
    String? shortName,
    int? directionId,
    String? blockId,
    String? shapeId,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'route_id': routeId,
      'service_id': serviceId,
      'headsign': headsign,
      'short_name': shortName,
      'direction_id': directionId,
      'block_id': blockId,
      'shape_id': shapeId,
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      routeId: json['route_id'] as String,
      serviceId: json['service_id'] as String,
      headsign: json['headsign'] as String?,
      shortName: json['short_name'] as String?,
      directionId: json['direction_id'] as int?,
      blockId: json['block_id'] as String?,
      shapeId: json['shape_id'] as String?,
    );
  }
}