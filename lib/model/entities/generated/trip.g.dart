// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Trip',
  json,
  ($checkedConvert) {
    final val = Trip(
      id: $checkedConvert('id', (v) => v as String),
      routeShortName: $checkedConvert('route_short_name', (v) => v as String?),
      headsign: $checkedConvert('trip_headsign', (v) => v as String?),
      routeColor: $checkedConvert('route_color', (v) => v as String?),
      routeTextColor: $checkedConvert('route_text_color', (v) => v as String?),
      estimatedArrivalTime: $checkedConvert(
        'estimated_arrival_time',
        (v) => v as String?,
      ),
      scheduledArrivalTime: $checkedConvert(
        'scheduled_arrival_time',
        (v) => v as String?,
      ),
      delay: $checkedConvert('delay_minutes', (v) => (v as num?)?.toDouble()),
      arrivalMinutes: $checkedConvert(
        'arrival_minutes',
        (v) => (v as num?)?.toDouble(),
      ),
      status: $checkedConvert('status', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'routeShortName': 'route_short_name',
    'headsign': 'trip_headsign',
    'routeColor': 'route_color',
    'routeTextColor': 'route_text_color',
    'estimatedArrivalTime': 'estimated_arrival_time',
    'scheduledArrivalTime': 'scheduled_arrival_time',
    'delay': 'delay_minutes',
    'arrivalMinutes': 'arrival_minutes',
  },
);

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
  'id': instance.id,
  'trip_headsign': instance.headsign,
  'route_short_name': instance.routeShortName,
  'route_color': instance.routeColor,
  'route_text_color': instance.routeTextColor,
  'estimated_arrival_time': instance.estimatedArrivalTime,
  'scheduled_arrival_time': instance.scheduledArrivalTime,
  'delay_minutes': instance.delay,
  'arrival_minutes': instance.arrivalMinutes,
  'status': instance.status,
};
