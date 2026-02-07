// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportRoute _$TransportRouteFromJson(Map<String, dynamic> json) =>
    TransportRoute(
      id: json['route_id'] as String,
      shortName: json['route_short_name'] as String?,
      longName: json['route_long_name'] as String?,
      displayName: json['display_name'] as String?,
      directionName: json['direction_name'] as String?,
      directionId: (json['direction_id'] as num?)?.toInt(),
      color: json['route_color'] as String?,
      textColor: json['route_text_color'] as String?,
    );

Map<String, dynamic> _$TransportRouteToJson(TransportRoute instance) =>
    <String, dynamic>{
      'route_id': instance.id,
      'direction_id': instance.directionId,
      'route_short_name': instance.shortName,
      'route_long_name': instance.longName,
      'display_name': instance.displayName,
      'direction_name': instance.directionName,
      'route_color': instance.color,
      'route_text_color': instance.textColor,
    };
