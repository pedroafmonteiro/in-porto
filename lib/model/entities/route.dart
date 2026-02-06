import 'package:in_porto/model/navigation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable()
class TransportRoute implements NavigationOverride {
  final String id;

  @JsonKey(name: 'number')
  final String? number;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'color')
  final String? color;

  @JsonKey(name: 'text_color')
  final String? textColor;

  const TransportRoute({
    required this.id,
    this.number,
    this.name,
    this.color,
    this.textColor,
  });

  factory TransportRoute.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? json['route_id'];

    final modifiedJson = Map<String, dynamic>.from(json);
    modifiedJson['id'] = id;

    return _$TransportRouteFromJson(modifiedJson);
  }

  Map<String, dynamic> toJson() => _$TransportRouteToJson(this);
}
