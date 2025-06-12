import 'package:flutter/foundation.dart';
import 'package:sandcat/app/config/app_config.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// 日志级别枚举
enum LogLevel {
  /// 详细日志
  verbose,

  /// 调试日志
  debug,

  /// 信息日志
  info,

  /// 警告日志
  warning,

  /// 错误日志
  error,

  /// 严重错误日志
  wtf,
}

/// 日志服务接口定义
abstract class LoggerService {
  /// 打印详细日志
  void v(dynamic message, {String? tag, dynamic error, StackTrace? stackTrace});

  /// 打印调试日志
  void d(dynamic message, {String? tag, dynamic error, StackTrace? stackTrace});

  /// 打印信息日志
  void i(dynamic message, {String? tag, dynamic error, StackTrace? stackTrace});

  /// 打印警告日志
  void w(dynamic message, {String? tag, dynamic error, StackTrace? stackTrace});

  /// 打印错误日志
  void e(dynamic message, {String? tag, dynamic error, StackTrace? stackTrace});

  /// 打印严重错误日志
  void wtf(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace});
}

/// Talker日志服务实现
class TalkerLoggerService implements LoggerService {
  /// 内部Talker实例
  final Talker _talker;

  /// 当前环境下是否启用控制台日志
  final bool _enableConsoleOutput;

  /// 当前最小日志级别
  final LogLevel _minLogLevel;

  /// 创建日志服务
  TalkerLoggerService()
      : _talker = TalkerFlutter.init(),
        _enableConsoleOutput = !AppConfig.isProduction || kDebugMode,
        _minLogLevel = _getDefaultLogLevel();

  /// 根据当前环境获取默认日志级别
  static LogLevel _getDefaultLogLevel() {
    if (AppConfig.isProduction) {
      return LogLevel.error; // 生产环境只记录错误
    } else if (AppConfig.isStaging) {
      return LogLevel.info; // 测试环境记录信息及以上
    } else {
      return LogLevel.verbose; // 开发环境记录所有
    }
  }

  /// 检查是否应该记录该级别的日志
  bool _shouldLog(LogLevel level) {
    return _enableConsoleOutput && level.index >= _minLogLevel.index;
  }

  @override
  void v(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_shouldLog(LogLevel.verbose)) {
      _talker.good(message);
    }
  }

  @override
  void d(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_shouldLog(LogLevel.debug)) {
      _talker.debug(message);
    }
  }

  @override
  void i(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_shouldLog(LogLevel.info)) {
      _talker.info(message);
    }
  }

  @override
  void w(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_shouldLog(LogLevel.warning)) {
      _talker.warning(message);
    }
  }

  @override
  void e(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _talker.error(message, error, stackTrace);
  }

  @override
  void wtf(dynamic message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _talker.critical(message);
  }
}

/// 全局日志实例，方便直接使用
final log = TalkerLoggerService();
