import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'storage_service.dart';

/// 安全存储服务实现
@LazySingleton(as: StorageService)
@Named('secure')
class SecureStorage implements StorageService {
  late final FlutterSecureStorage _storage;

  /// 创建安全存储服务
  SecureStorage() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<void> initialize() async {
    // 安全存储不需要额外初始化
  }

  @override
  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<bool?> getBool(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<int?> getInt(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<double?> getDouble(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    final jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final jsonString = await _storage.read(key: key);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded.map((e) => e.toString()).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> set<T>(String key, T value) async {
    final jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  @override
  Future<T?> get<T>(String key) async {
    final jsonString = await _storage.read(key: key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as T;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
