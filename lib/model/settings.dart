class Settings {
  final String appearance;
  final String language;

  Settings({
    required this.appearance,
    required this.language,
  });

  Settings copyWith({
    String? appearance,
    String? language,
  }) {
    return Settings(
      appearance: appearance ?? this.appearance,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appearance': appearance,
      'language': language,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      appearance: json['appearance'] ?? 'system',
      language: json['language'] ?? 'system',
    );
  }
}