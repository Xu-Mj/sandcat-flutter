import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 加密服务接口
abstract class EncryptionService {
  /// 加密数据
  Future<String> encrypt(String data);

  /// 解密数据
  Future<String> decrypt(String encryptedData);

  /// 加密字节数据
  Future<Uint8List> encryptBytes(Uint8List data);

  /// 解密字节数据
  Future<Uint8List> decryptBytes(Uint8List encryptedData);

  /// 生成数据哈希
  String generateHash(String data);

  /// 验证哈希
  bool verifyHash(String data, String hash);

  /// 初始化加密服务
  Future<void> initialize();

  /// 重置加密密钥
  Future<void> resetKeys();
}

/// AES加密服务
class AESEncryptionService implements EncryptionService {
  /// 安全存储
  final FlutterSecureStorage _secureStorage;

  /// 加密器
  late Encrypter _encrypter;

  /// 初始化向量
  late IV _iv;

  /// 密钥存储键
  static const String _keyStorageKey = 'encryption_key';

  /// IV存储键
  static const String _ivStorageKey = 'encryption_iv';

  /// 创建AES加密服务
  AESEncryptionService({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<void> initialize() async {
    // 检查是否已有密钥
    String? storedKey = await _secureStorage.read(key: _keyStorageKey);
    String? storedIv = await _secureStorage.read(key: _ivStorageKey);

    if (storedKey == null || storedIv == null) {
      // 生成新密钥
      await resetKeys();
    } else {
      // 使用存储的密钥
      final key = Key(base64Decode(storedKey));
      _iv = IV(base64Decode(storedIv));
      _encrypter = Encrypter(AES(key));
    }
  }

  @override
  Future<void> resetKeys() async {
    // 生成随机密钥和IV
    final key = Key.fromSecureRandom(32);
    _iv = IV.fromSecureRandom(16);

    // 保存密钥和IV
    await _secureStorage.write(
      key: _keyStorageKey,
      value: base64Encode(key.bytes),
    );

    await _secureStorage.write(
      key: _ivStorageKey,
      value: base64Encode(_iv.bytes),
    );

    _encrypter = Encrypter(AES(key));
  }

  @override
  Future<String> encrypt(String data) async {
    final encrypted = _encrypter.encrypt(data, iv: _iv);
    return encrypted.base64;
  }

  @override
  Future<String> decrypt(String encryptedData) async {
    try {
      final encrypted = Encrypted.fromBase64(encryptedData);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e) {
      throw FormatException('解密失败: $e');
    }
  }

  @override
  Future<Uint8List> encryptBytes(Uint8List data) async {
    final dataString = base64Encode(data);
    final encrypted = await encrypt(dataString);
    return base64Decode(encrypted);
  }

  @override
  Future<Uint8List> decryptBytes(Uint8List encryptedData) async {
    final encryptedString = base64Encode(encryptedData);
    final decrypted = await decrypt(encryptedString);
    return base64Decode(decrypted);
  }

  @override
  String generateHash(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  bool verifyHash(String data, String hash) {
    final generatedHash = generateHash(data);
    return generatedHash == hash;
  }
}

/// 加密服务工厂
class EncryptionServiceFactory {
  /// 创建加密服务
  static Future<EncryptionService> createService({
    String type = 'aes',
    FlutterSecureStorage? secureStorage,
  }) async {
    EncryptionService service;

    switch (type.toLowerCase()) {
      case 'aes':
        service = AESEncryptionService(secureStorage: secureStorage);
        break;
      default:
        throw ArgumentError('不支持的加密类型: $type');
    }

    await service.initialize();
    return service;
  }
}
