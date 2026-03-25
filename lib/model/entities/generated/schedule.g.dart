// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Schedule',
  json,
  ($checkedConvert) {
    final val = Schedule(
      stopId: $checkedConvert('stop_id', (v) => v as String),
      routeId: $checkedConvert('route_id', (v) => v as String),
      directionId: $checkedConvert('direction_id', (v) => v as String?),
      serviceId: $checkedConvert('service_id', (v) => v as String),
      departureTime: $checkedConvert('departure_time', (v) => v as String),
      headsign: $checkedConvert('headsign', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'stopId': 'stop_id',
    'routeId': 'route_id',
    'directionId': 'direction_id',
    'serviceId': 'service_id',
    'departureTime': 'departure_time',
  },
);

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
  'stop_id': instance.stopId,
  'route_id': instance.routeId,
  'direction_id': instance.directionId,
  'service_id': instance.serviceId,
  'departure_time': instance.departureTime,
  'headsign': instance.headsign,
};
