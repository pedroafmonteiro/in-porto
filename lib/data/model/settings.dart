class Settings {
  final String appearance;
  final String language;
  final int hasSeenOnboarding;

  Settings({
    required this.appearance,
    required this.language,
    required this.hasSeenOnboarding,
  });

  Settings copyWith({
    String? appearance,
    String? language,
    int? hasSeenOnboarding,
  }) {
    return Settings(
      appearance: appearance ?? this.appearance,
      language: language ?? this.language,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appearance': appearance,
      'language': language,
      'hasSeenOnboarding': hasSeenOnboarding,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      appearance: json['appearance'] ?? 'system',
      language: json['language'] ?? 'system',
      hasSeenOnboarding: json['hasSeenOnboarding'] ?? 0,
    );
  }
}