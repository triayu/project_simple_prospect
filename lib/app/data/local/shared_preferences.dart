import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class SharedPreferencesHelper {
  // Methods to read and write data to SharedPreferences

  // Method to read a Map<String, dynamic> from SharedPreferences
  static Map<String, dynamic> getMap(String key, [Map<String, dynamic> defaultValue = const {}]) {
    String jsonString = prefs.getString(key) ?? '';
    if (jsonString.isNotEmpty) {
      return json.decode(jsonString);
    }
    return defaultValue;
  }

  // Method to save a Map<String, dynamic> to SharedPreferences
  static Future<bool> setMap(String key, Map<String, dynamic> value) async {
    String jsonString = json.encode(value);
    return await prefs.setString(key, jsonString);
  }

  // Method to read a String from SharedPreferences
  static String getString(String key, [String defaultValue = ""]) {
    return prefs.getString(key) ?? defaultValue;
  }

  // Method to set a String to SharedPreferences
  static Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }
}
