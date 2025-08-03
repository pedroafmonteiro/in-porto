class Shape {
  /// Identifies a shape (required)
  final String shapeId;

  /// Latitude of a shape point (required)
  final double lat;

  /// Longitude of a shape point (required)
  final double lon;

  /// Sequence in which the shape points connect (required, non-negative integer)
  final int sequence;

  /// Actual distance traveled along the shape (optional, non-negative float)
  final double? distTraveled;

  Shape({
    required this.shapeId,
    required this.lat,
    required this.lon,
    required this.sequence,
    this.distTraveled,
  }) : assert(shapeId.isNotEmpty, 'shapeId cannot be empty'),
       assert(sequence >= 0, 'sequence must be non-negative'),
       assert(lat >= -90 && lat <= 90, 'lat must be between -90 and 90'),
       assert(lon >= -180 && lon <= 180, 'lon must be between -180 and 180'),
       assert(
         distTraveled == null || distTraveled >= 0,
         'distTraveled must be non-negative',
       );

  factory Shape.fromMap(Map<String, dynamic> map) {
    return Shape(
      shapeId: map['shape_id'] as String,
      lat: map['shape_pt_lat'] as double,
      lon: map['shape_pt_lon'] as double,
      sequence: map['shape_pt_sequence'] as int,
      distTraveled: map['shape_dist_traveled'] as double?,
    );
  }

  @override
  String toString() {
    return 'Shape(shapeId: $shapeId, lat: $lat, lon: $lon, sequence: $sequence, distTraveled: $distTraveled)';
  }
}
