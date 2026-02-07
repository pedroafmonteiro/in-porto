import 'package:in_porto/model/navigation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable()
class TransportRoute implements NavigationOverride {
  @JsonKey(name: 'route_id')
  final String id;

  @JsonKey(name: 'direction_id')
  final int? directionId;

  @JsonKey(name: 'route_short_name')
  final String? shortName;

  @JsonKey(name: 'route_long_name')
  final String? longName;

  @JsonKey(name: 'display_name')
  final String? displayName;

  @JsonKey(name: 'direction_name')
  final String? directionName;

  @JsonKey(name: 'route_color')
  final String? color;

  @JsonKey(name: 'route_text_color')
  final String? textColor;

  const TransportRoute({
    required this.id,
    this.shortName,
    this.longName,
    this.displayName,
    this.directionName,
    this.directionId,
    this.color,
    this.textColor,
  });

  factory TransportRoute.fromJson(Map<String, dynamic> json) =>
      _$TransportRouteFromJson(json);

  Map<String, dynamic> toJson() => _$TransportRouteToJson(this);
}
