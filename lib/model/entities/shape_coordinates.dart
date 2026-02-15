import 'package:json_annotation/json_annotation.dart';

part 'shape_coordinates.g.dart';

@JsonSerializable()
class ShapeCoordinates {
  @JsonKey(name: 'route_id')
  final String? routeId;

  @JsonKey(name: 'direction_id')
  final int? directionId;

  @JsonKey(name: 'lat')
  final double? latitude;

  @JsonKey(name: 'lng')
  final double? longitude;

  @JsonKey(name: 'sequence')
  final int? sequence;

  ShapeCoordinates({
    this.routeId,
    this.directionId,
    this.latitude,
    this.longitude,
    this.sequence,
  });

  factory ShapeCoordinates.fromJson(Map<String, dynamic> json) =>
      _$ShapeCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$ShapeCoordinatesToJson(this);
}