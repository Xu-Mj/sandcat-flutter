import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sandcat/core/errors/exceptions.dart';
import 'package:sandcat/core/errors/failures.dart';
import 'package:injectable/injectable.dart';
import '../services/logger_service.dart';

@injectable
class ErrorHandler {
  final LoggerService _logger;

  /// 创建错误处理器实例
  /// [logger] 日志服务，用于记录错误
  ErrorHandler({
    required LoggerService logger,
  }) : _logger = logger;

  Failure handleException(dynamic exception) {
    if (exception is ServerException) {
      return Failure.server(exception.message);
    } else if (exception is NetworkException || exception is SocketException) {
      final message = exception is NetworkException
          ? exception.message
          : 'Connection failed';
      return Failure.network(message);
    } else if (exception is CacheException) {
      return Failure.cache(exception.message);
    } else if (exception is UnauthorizedException) {
      return Failure.unauthorized(exception.message);
    } else if (exception is ValidationException) {
      return Failure.validation(exception.message);
    } else if (exception is DioException) {
      return _handleDioException(exception);
    } else {
      return Failure.unexpected(exception.toString());
    }
  }

  Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return Failure.unauthorized(
              exception.response?.statusMessage ?? 'Authentication failed');
        }
        return Failure.server(
            exception.response?.statusMessage ?? 'Server error');
      case DioExceptionType.cancel:
        return const Failure.network('Request cancelled');
      default:
        return Failure.unexpected(exception.toString());
    }
  }

  /// 处理一般错误
  void handleError(dynamic error, [StackTrace? stackTrace]) {
    _logger.e('Error occurred', error: error, stackTrace: stackTrace);
    // 这里可以添加错误报告、分析等逻辑
  }
}
