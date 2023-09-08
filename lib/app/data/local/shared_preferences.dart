import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  late SharedPreferences _prefs;

  // Private constructor to ensure a single instance of SharedPreferencesHelper
  SharedPreferencesHelper._();

  // Singleton instance
  static final SharedPreferencesHelper instance = SharedPreferencesHelper._();

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Methods to read and write data to SharedPreferences

  String getString(String key, [String defaultValue = ""]) {
    return _prefs.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  int getInt(String key, [int defaultValue = 0]) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  double getDouble(String key, [double defaultValue = 0.0]) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  bool getBool(String key, [bool defaultValue = false]) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  List<String> getStringList(String key, [List<String> defaultValue = const []]) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  // Remove a specific key from SharedPreferences
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  // Clear all data from SharedPreferences
  Future<bool> clear() {
    return _prefs.clear();
  }
}