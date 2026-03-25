// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stop _$StopFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Stop',
  json,
  ($checkedConvert) {
    final val = Stop(
      id: $checkedConvert('stop_id', (v) => v as String),
      code: $checkedConvert('stop_code', (v) => v as String?),
      name: $checkedConvert('stop_name', (v) => v as String?),
      latitude: $checkedConvert('stop_lat', (v) => (v as num?)?.toDouble()),
      longitude: $checkedConvert('stop_lon', (v) => (v as num?)?.toDouble()),
      zoneId: $checkedConvert('zone_id', (v) => v as String?),
      sequence: $checkedConvert('stop_sequence', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'id': 'stop_id',
    'code': 'stop_code',
    'name': 'stop_name',
    'latitude': 'stop_lat',
    'longitude': 'stop_lon',
    'zoneId': 'zone_id',
    'sequence': 'stop_sequence',
  },
);

Map<String, dynamic> _$StopToJson(Stop instance) => <String, dynamic>{
  'stop_id': instance.id,
  'stop_code': instance.code,
  'stop_name': instance.name,
  'stop_lat': instance.latitude,
  'stop_lon': instance.longitude,
  'zone_id': instance.zoneId,
  'stop_sequence': instance.sequence,
};
