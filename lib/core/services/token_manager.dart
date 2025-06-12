import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandcat/core/services/logger_service.dart';

/// 令牌管理器 - 单一职责：存储和提供访问令牌
@singleton
class TokenManager {
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';

  String? _accessToken;
  String? _refreshToken;

  /// 初始化，从持久化存储中加载令牌
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString(_accessTokenKey);
      _refreshToken = prefs.getString(_refreshTokenKey);
      log.d('已加载令牌: ${_accessToken != null ? '存在' : '不存在'}',
          tag: 'TokenManager');
    } catch (e) {
      log.e('加载令牌失败', error: e, tag: 'TokenManager');
    }
  }

  /// 设置访问令牌
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, token);
    } catch (e) {
      log.e('保存访问令牌失败', error: e, tag: 'TokenManager');
    }
  }

  /// 设置刷新令牌
  Future<void> setRefreshToken(String token) async {
    _refreshToken = token;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshTokenKey, token);
    } catch (e) {
      log.e('保存刷新令牌失败', error: e, tag: 'TokenManager');
    }
  }

  /// 获取访问令牌
  String? getAccessToken() {
    return _accessToken;
  }

  /// 获取刷新令牌
  String? getRefreshToken() {
    return _refreshToken;
  }

  /// 清除所有令牌
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_refreshTokenKey);
      log.d('已清除令牌', tag: 'TokenManager');
    } catch (e) {
      log.e('清除令牌失败', error: e, tag: 'TokenManager');
    }
  }
}
