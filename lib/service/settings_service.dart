import 'package:in_porto/model/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService._privateConstructor();

  static final SettingsService _instance = SettingsService._privateConstructor();

  factory SettingsService() {
    return _instance;
  }

  static const _keyAppearance = 'appearance';
  static const _keyLanguage = 'language';

  Future<Settings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final appearance = prefs.getString(_keyAppearance) ?? 'system';
    final language = prefs.getString(_keyLanguage) ?? 'system';
    return Settings(appearance: appearance, language: language);
  }

  Future<void> saveSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAppearance, settings.appearance);
    await prefs.setString(_keyLanguage, settings.language);
  }
}