class Stop {
  final String id;
  final String? code;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final String? zoneId;
  final String? url;

  Stop({
    required this.id,
    this.code,
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
    this.zoneId,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'zone_id': zoneId,
      'url': url,
    };
  }

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['id'] as String,
      code: json['code'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      zoneId: json['zone_id'] as String?,
      url: json['url'] as String?,
    );
  }
}