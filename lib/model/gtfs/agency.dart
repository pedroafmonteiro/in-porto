class Agency {
  final String name;
  final String url;
  final String timezone;
  final String? language;

  Agency({
    required this.name,
    required this.url,
    required this.timezone,
    this.language,
  });

  Agency copyWith({
    String? name,
    String? url,
    String? timezone,
    String? language,
  }) {
    return Agency(
      name: name ?? this.name,
      url: url ?? this.url,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'timezone': timezone,
      'language': language,
    };
  }

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      name: json['name'] as String,
      url: json['url'] as String,
      timezone: json['timezone'] as String,
      language: json['language'] as String?,
    );
  }
}