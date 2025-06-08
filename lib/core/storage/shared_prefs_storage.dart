import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';

/// Implements the [StorageService] using SharedPreferences
class SharedPrefsStorage implements StorageService {
  SharedPreferences? _prefs;

  @override
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> setString(String key, String value) async {
    _checkInitialized();
    await _prefs!.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    _checkInitialized();
    return _prefs!.getString(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    _checkInitialized();
    await _prefs!.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    _checkInitialized();
    return _prefs!.getBool(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    _checkInitialized();
    await _prefs!.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    _checkInitialized();
    return _prefs!.getInt(key);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    _checkInitialized();
    await _prefs!.setDouble(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    _checkInitialized();
    return _prefs!.getDouble(key);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    _checkInitialized();
    await _prefs!.setStringList(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    _checkInitialized();
    return _prefs!.getStringList(key);
  }

  @override
  @experimental
  Future<void> set<T>(String key, T value) async {
    _checkInitialized();

    if (value is String) {
      await setString(key, value);
    } else if (value is bool) {
      await setBool(key, value);
    } else if (value is int) {
      await setInt(key, value);
    } else if (value is double) {
      await setDouble(key, value);
    } else if (value is List<String>) {
      await setStringList(key, value);
    } else {
      try {
        final jsonString = jsonEncode(value);
        await _prefs!.setString(key, jsonString);
      } catch (e) {
        throw UnsupportedError('Unsupported type: ${value.runtimeType}');
      }
    }
  }

  @override
  @experimental
  Future<T?> get<T>(String key) async {
    _checkInitialized();

    final value = _prefs!.get(key);
    if (value == null) return null;

    if (T == String || value is String && T == dynamic) {
      return value as T?;
    } else if (T == bool || value is bool && T == dynamic) {
      return value as T?;
    } else if (T == int || value is int && T == dynamic) {
      return value as T?;
    } else if (T == double || value is double && T == dynamic) {
      return value as T?;
    } else if (value is List<String>) {
      return value as T?;
    } else {
      try {
        final jsonString = _prefs!.getString(key);
        if (jsonString == null) return null;
        return jsonDecode(jsonString) as T?;
      } catch (_) {
        return null;
      }
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    _checkInitialized();
    return _prefs!.containsKey(key);
  }

  @override
  Future<void> remove(String key) async {
    _checkInitialized();
    await _prefs!.remove(key);
  }

  @override
  Future<void> clear() async {
    _checkInitialized();
    await _prefs!.clear();
  }

  void _checkInitialized() {
    if (_prefs == null) {
      throw StateError(
          'SharedPrefsStorage is not initialized. Call initialize() first.');
    }
  }
}
