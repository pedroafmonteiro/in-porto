// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
  stopId: json['stop_id'] as String,
  routeId: json['route_id'] as String,
  directionId: json['direction_id'] as String?,
  serviceId: json['service_id'] as String,
  departureTime: json['departure_time'] as String,
  headsign: json['headsign'] as String?,
);

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
  'stop_id': instance.stopId,
  'route_id': instance.routeId,
  'direction_id': instance.directionId,
  'service_id': instance.serviceId,
  'departure_time': instance.departureTime,
  'headsign': instance.headsign,
};
