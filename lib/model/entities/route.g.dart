// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportRoute _$TransportRouteFromJson(Map<String, dynamic> json) =>
    TransportRoute(
      id: json['id'] as String,
      number: json['number'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      textColor: json['text_color'] as String?,
    );

Map<String, dynamic> _$TransportRouteToJson(TransportRoute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'name': instance.name,
      'color': instance.color,
      'text_color': instance.textColor,
    };
