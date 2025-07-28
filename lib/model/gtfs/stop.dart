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
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      zoneId: json['zone_id'],
      url: json['url'],
    );
  }
}