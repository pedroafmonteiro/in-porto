// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stop _$StopFromJson(Map<String, dynamic> json) => Stop(
  id: json['stop_id'] as String,
  code: json['stop_code'] as String?,
  name: json['stop_name'] as String?,
  description: json['stop_desc'] as String?,
  latitude: (json['stop_lat'] as num?)?.toDouble(),
  longitude: (json['stop_lon'] as num?)?.toDouble(),
  zoneId: json['zone_id'] as String?,
  routes: (json['routes'] as List<dynamic>?)
      ?.map((e) => TransportRoute.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StopToJson(Stop instance) => <String, dynamic>{
  'stop_id': instance.id,
  'stop_code': instance.code,
  'stop_name': instance.name,
  'stop_desc': instance.description,
  'stop_lat': instance.latitude,
  'stop_lon': instance.longitude,
  'zone_id': instance.zoneId,
  'routes': instance.routes,
};
