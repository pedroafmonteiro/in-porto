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

  Shape copyWith({
    String? shapeId,
    double? lat,
    double? lon,
    int? sequence,
    double? distTraveled,
  }) {
    return Shape(
      shapeId: shapeId ?? this.shapeId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      sequence: sequence ?? this.sequence,
      distTraveled: distTraveled ?? this.distTraveled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shape_id': shapeId,
      'shape_pt_lat': lat,
      'shape_pt_lon': lon,
      'shape_pt_sequence': sequence,
      if (distTraveled != null) 'shape_dist_traveled': distTraveled,
    };
  }

  factory Shape.fromJson(Map<String, dynamic> json) {
    return Shape(
      shapeId: json['shape_id'] as String,
      lat: json['shape_pt_lat'] is double
          ? json['shape_pt_lat'] as double
          : double.parse(json['shape_pt_lat'].toString()),
      lon: json['shape_pt_lon'] is double
          ? json['shape_pt_lon'] as double
          : double.parse(json['shape_pt_lon'].toString()),
      sequence: json['shape_pt_sequence'] is int
          ? json['shape_pt_sequence'] as int
          : int.parse(json['shape_pt_sequence'].toString()),
      distTraveled: json['shape_dist_traveled'] == null
          ? null
          : (json['shape_dist_traveled'] is double
                ? json['shape_dist_traveled'] as double
                : double.tryParse(json['shape_dist_traveled'].toString())),
    );
  }

  @override
  String toString() {
    return 'Shape(shapeId: $shapeId, lat: $lat, lon: $lon, sequence: $sequence, distTraveled: $distTraveled)';
  }
}
