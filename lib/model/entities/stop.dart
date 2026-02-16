import 'package:in_porto/model/navigation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stop.g.dart';

@JsonSerializable()
class Stop implements NavigationOverride {
  @JsonKey(name: 'stop_id')
  final String id;

  @JsonKey(name: 'stop_code')
  final String? code;

  @JsonKey(name: 'stop_name')
  final String? name;

  @JsonKey(name: 'stop_lat')
  final double? latitude;

  @JsonKey(name: 'stop_lon')
  final double? longitude;

  @JsonKey(name: 'zone_id')
  final String? zoneId;

  @JsonKey(name: 'stop_sequence') // when fetching stops from a specific route
  final int? sequence;

  const Stop({
    required this.id,
    this.code,
    this.name,
    this.latitude,
    this.longitude,
    this.zoneId,
    this.sequence,
  });

  factory Stop.fromJson(Map<String, dynamic> json) => _$StopFromJson(json);
  Map<String, dynamic> toJson() => _$StopToJson(this);
}
