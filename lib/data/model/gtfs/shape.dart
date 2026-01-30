import 'package:objectbox/objectbox.dart';

@Entity()
class Shape {
  @Id()
  int id = 0;

  @Index()
  final String shapeId;

  @Index()
  final String? agencyId;

  final double lat;

  final double lon;

  final int sequence;

  final double? distTraveled;

  Shape({
    this.id = 0,
    required this.shapeId,
    this.agencyId,
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
      shapeId: map['shape_id']?.toString() ?? '',
      agencyId: map['agency_id']?.toString(),
      lat: double.tryParse(map['shape_pt_lat']?.toString() ?? '') ?? 0.0,
      lon: double.tryParse(map['shape_pt_lon']?.toString() ?? '') ?? 0.0,
      sequence: int.tryParse(map['shape_pt_sequence']?.toString() ?? '') ?? 0,
      distTraveled: double.tryParse(
        map['shape_dist_traveled']?.toString() ?? '',
      ),
    );
  }

  @override
  String toString() {
    return 'Shape(shapeId: $shapeId, lat: $lat, lon: $lon, sequence: $sequence, distTraveled: $distTraveled)';
  }
}
