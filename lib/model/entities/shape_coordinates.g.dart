// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape_coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShapeCoordinates _$ShapeCoordinatesFromJson(Map<String, dynamic> json) =>
    ShapeCoordinates(
      routeId: json['route_id'] as String?,
      directionId: (json['direction_id'] as num?)?.toInt(),
      latitude: (json['lat'] as num?)?.toDouble(),
      longitude: (json['lng'] as num?)?.toDouble(),
      sequence: (json['sequence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShapeCoordinatesToJson(ShapeCoordinates instance) =>
    <String, dynamic>{
      'route_id': instance.routeId,
      'direction_id': instance.directionId,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'sequence': instance.sequence,
    };
