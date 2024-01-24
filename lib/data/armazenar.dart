import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Armazenar {
  static Future<bool> salvarString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> salvaMap(String key, Map<String, dynamic> value) async {
    return salvarString(key, jsonEncode(value));
  }

  static Future<String> lerString(String key,
      [String defaultValue = '']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<Map<String, dynamic>> lerMap(String key) async {
    try {
      return jsonDecode(await lerString(key));
    } catch (erro) {
      return {};
    }
  }

  static Future<bool> remover(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
