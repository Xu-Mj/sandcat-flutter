import 'package:flutter/foundation.dart';

/// 环境类型枚举
enum Environment {
  /// 开发环境
  development,

  /// 测试环境
  staging,

  /// 生产环境
  production,
}

/// 应用配置类
class AppConfig {
  /// 当前环境
  final Environment environment;

  /// 应用名称
  final String appName;

  /// 应用版本
  final String appVersion;

  /// 应用构建号
  final String buildNumber;

  /// 创建应用配置
  AppConfig({
    required this.environment,
    required this.appName,
    required this.appVersion,
    required this.buildNumber,
  });

  /// 当前配置实例
  static late AppConfig _instance;

  /// 初始化配置
  static void initialize({
    Environment? environment,
    required String appName,
    required String appVersion,
    required String buildNumber,
  }) {
    _instance = AppConfig(
      environment: environment ??
          (kReleaseMode ? Environment.production : Environment.development),
      appName: appName,
      appVersion: appVersion,
      buildNumber: buildNumber,
    );
  }

  /// 获取当前配置
  static AppConfig get instance => _instance;

  /// 是否为开发环境
  static bool get isDevelopment =>
      _instance.environment == Environment.development;

  /// 是否为测试环境
  static bool get isStaging => _instance.environment == Environment.staging;

  /// 是否为生产环境
  static bool get isProduction =>
      _instance.environment == Environment.production;
}
