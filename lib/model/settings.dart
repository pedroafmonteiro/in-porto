class Settings {
  final String appearance;

  Settings({
    required this.appearance,
  });

  Settings copyWith({
    String? appearance,
  }) {
    return Settings(
      appearance: appearance ?? this.appearance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appearance': appearance,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      appearance: json['appearance'] ?? 'system',
    );
  }
}