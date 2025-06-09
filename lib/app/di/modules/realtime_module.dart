import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:im_flutter/core/realtime/realtime_client.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'package:im_flutter/features/auth/data/repositories/auth_repository.dart';
import 'package:im_flutter/features/chat/presentation/providers/message_provider.dart';

/// 实时消息模块依赖注入配置
@module
abstract class RealtimeModule {
  /// 注册MessageProvider
  @lazySingleton
  MessageProvider provideMessageProvider(
    RealtimeClient realtimeClient,
    LoggerService loggerService,
    AuthRepository authRepository,
  ) {
    // 从AuthRepository获取当前用户ID
    final userId = authRepository.userId ?? '';

    return MessageProvider(
      realtimeClient: realtimeClient,
      logger: loggerService,
      userId: userId,
    );
  }
}
