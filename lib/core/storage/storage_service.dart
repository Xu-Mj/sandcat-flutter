import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Interface for key-value storage operations
abstract class StorageService {
  /// Initialize the storage service
  Future<void> initialize();

  /// Store a string value
  Future<void> setString(String key, String value);

  /// Retrieve a string value
  Future<String?> getString(String key);

  /// Store a bool value
  Future<void> setBool(String key, bool value);

  /// Retrieve a bool value
  Future<bool?> getBool(String key);

  /// Store an int value
  Future<void> setInt(String key, int value);

  /// Retrieve an int value
  Future<int?> getInt(String key);

  /// Store a double value
  Future<void> setDouble(String key, double value);

  /// Retrieve a double value
  Future<double?> getDouble(String key);

  /// Store a list of strings
  Future<void> setStringList(String key, List<String> value);

  /// Retrieve a list of strings
  Future<List<String>?> getStringList(String key);

  /// Store any value that can be JSON encoded
  @experimental
  Future<void> set<T>(String key, T value);

  /// Retrieve and decode a JSON encoded value
  @experimental
  Future<T?> get<T>(String key);

  /// Check if a key exists
  Future<bool> containsKey(String key);

  /// Remove a key-value pair
  Future<void> remove(String key);

  /// Clear all data
  Future<void> clear();
}
