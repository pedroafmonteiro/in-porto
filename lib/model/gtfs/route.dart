class Route {
  final String id;
  final String? shortName;
  final String? longName;
  final String? description;
  final String type;
  final String? color;
  final String? textColor;

  Route({
    required this.id,
    this.shortName,
    this.longName,
    this.description,
    required this.type,
    this.color,
    this.textColor,
  }) : assert(
         (shortName != null && shortName.isNotEmpty) ||
             (longName != null && longName.isNotEmpty),
         'Either shortName or longName must be provided and non-empty',
       );

  Route copyWith({
    String? id,
    String? shortName,
    String? longName,
    String? description,
    String? type,
    String? color,
    String? textColor,
  }) {
    return Route(
      id: id ?? this.id,
      shortName: shortName ?? this.shortName,
      longName: longName ?? this.longName,
      description: description ?? this.description,
      type: type ?? this.type,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'short_name': shortName,
      'long_name': longName,
      'description': description,
      'type': type,
      'color': color,
      'text_color': textColor,
    };
  }

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'] as String,
      shortName: json['short_name'] as String,
      longName: json['long_name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      color: json['color'] as String?,
      textColor: json['text_color'] as String?,
    );
  }
}
