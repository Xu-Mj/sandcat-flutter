import 'package:im_flutter/core/services/logger_service.dart';

/// 演示如何使用日志服务
void demonstrateLogging() {
  // 方法1: 使用全局实例
  log.i('这是一条信息日志');
  log.d('这是一条调试日志');
  log.w('这是一条警告日志');
  log.e('这是一条错误日志', error: Exception('测试异常'), stackTrace: StackTrace.current);
  log.wtf('这是一条严重错误日志');

  // 方法2: 通过依赖注入获取实例
  // final logger = getIt<LoggerService>();
  // logger.i('信息');

  // 使用标签
  log.i('带标签的日志', tag: 'UI');

  try {
    // 制造一个异常
    throw Exception('这是一个测试异常');
  } catch (e, stackTrace) {
    // 记录异常和堆栈
    log.e('捕获到异常', error: e, stackTrace: stackTrace);
  }
}
