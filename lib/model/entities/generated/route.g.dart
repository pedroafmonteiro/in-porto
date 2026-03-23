// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportRoute _$TransportRouteFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TransportRoute',
      json,
      ($checkedConvert) {
        final val = TransportRoute(
          id: $checkedConvert('route_id', (v) => v as String),
          shortName: $checkedConvert('route_short_name', (v) => v as String?),
          longName: $checkedConvert('route_long_name', (v) => v as String?),
          displayName: $checkedConvert('display_name', (v) => v as String?),
          directionName: $checkedConvert('direction_name', (v) => v as String?),
          tripHeadsign: $checkedConvert('trip_headsign', (v) => v as String?),
          directionId: $checkedConvert(
            'direction_id',
            (v) => (v as num?)?.toInt(),
          ),
          color: $checkedConvert('route_color', (v) => v as String?),
          textColor: $checkedConvert('route_text_color', (v) => v as String?),
          stopIds: $checkedConvert(
            'stopIds',
            (v) =>
                (v as List<dynamic>?)?.map((e) => e as String?).toList() ??
                const [],
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'route_id',
        'shortName': 'route_short_name',
        'longName': 'route_long_name',
        'displayName': 'display_name',
        'directionName': 'direction_name',
        'tripHeadsign': 'trip_headsign',
        'directionId': 'direction_id',
        'color': 'route_color',
        'textColor': 'route_text_color',
      },
    );

Map<String, dynamic> _$TransportRouteToJson(TransportRoute instance) =>
    <String, dynamic>{
      'route_id': instance.id,
      'direction_id': instance.directionId,
      'route_short_name': instance.shortName,
      'route_long_name': instance.longName,
      'display_name': instance.displayName,
      'direction_name': instance.directionName,
      'trip_headsign': instance.tripHeadsign,
      'route_color': instance.color,
      'route_text_color': instance.textColor,
      'stopIds': instance.stopIds,
    };
