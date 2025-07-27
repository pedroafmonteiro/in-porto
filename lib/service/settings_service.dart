import 'package:in_porto/model/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService._privateConstructor();

  static final SettingsService _instance = SettingsService._privateConstructor();

  factory SettingsService() {
    return _instance;
  }

  static const _keyAppearance = 'appearance';

  Future<Settings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final appearance = prefs.getString(_keyAppearance) ?? 'system';
    return Settings(appearance: appearance);
  }

  Future<void> saveSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAppearance, settings.appearance);
  }
}