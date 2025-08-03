import 'package:flutter/material.dart';
import 'package:in_porto/model/settings.dart';
import 'package:in_porto/service/settings_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsService _service = SettingsService();
  late Settings _settings;

  bool _initialized = false;

  SettingsViewModel();

  Settings get settings => _settings;
  bool get initialized => _initialized;

  Future<void> load() async {
    _settings = await _service.loadSettings();
    _initialized = true;
    notifyListeners();
  }

  void setAppearance(String appearance) {
    _settings = _settings.copyWith(appearance: appearance);
    _service.saveSettings(_settings);
    notifyListeners();
  }

  void setLanguage(String language) {
    _settings = _settings.copyWith(language: language);
    _service.saveSettings(_settings);
    notifyListeners();
  }

  void setHasSeenOnboarding(int hasSeenOnboarding) {
    _settings = _settings.copyWith(hasSeenOnboarding: hasSeenOnboarding);
    _service.saveSettings(_settings);
    notifyListeners();
  }
}
