// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
  id: json['id'] as String,
  routeShortName: json['route_short_name'] as String?,
  headsign: json['trip_headsign'] as String?,
  routeColor: json['route_color'] as String?,
  routeTextColor: json['route_text_color'] as String?,
  estimatedArrivalTime: json['estimated_arrival_time'] as String?,
  scheduledArrivalTime: json['scheduled_arrival_time'] as String?,
  delay: (json['delay_minutes'] as num?)?.toDouble(),
  arrivalMinutes: (json['arrival_minutes'] as num?)?.toDouble(),
  status: json['status'] as String?,
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
