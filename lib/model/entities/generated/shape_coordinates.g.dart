// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../shape_coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShapeCoordinates _$ShapeCoordinatesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ShapeCoordinates',
      json,
      ($checkedConvert) {
        final val = ShapeCoordinates(
          routeId: $checkedConvert('route_id', (v) => v as String?),
          directionId: $checkedConvert(
            'direction_id',
            (v) => (v as num?)?.toInt(),
          ),
          latitude: $checkedConvert('lat', (v) => (v as num?)?.toDouble()),
          longitude: $checkedConvert('lng', (v) => (v as num?)?.toDouble()),
          sequence: $checkedConvert('sequence', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'routeId': 'route_id',
        'directionId': 'direction_id',
        'latitude': 'lat',
        'longitude': 'lng',
      },
    );

Map<String, dynamic> _$ShapeCoordinatesToJson(ShapeCoordinates instance) =>
    <String, dynamic>{
      'route_id': instance.routeId,
      'direction_id': instance.directionId,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'sequence': instance.sequence,
    };
