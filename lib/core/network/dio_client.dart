import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sandcat/app/config/api_config.dart';
import 'package:sandcat/core/services/logger_service.dart';
import 'package:sandcat/core/services/token_manager.dart';
import 'api_client.dart';

@LazySingleton(as: ApiClient)
class DioClient implements ApiClient {
  final Dio _dio;
  final TokenManager _tokenManager;

  DioClient(this._tokenManager)
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConfig.instance.baseUrl,
          connectTimeout:
              Duration(milliseconds: ApiConfig.instance.connectionTimeout),
          receiveTimeout:
              Duration(milliseconds: ApiConfig.instance.receiveTimeout),
          sendTimeout: Duration(milliseconds: ApiConfig.instance.sendTimeout),
        )) {
    // 添加日志拦截器
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          log.d('Dio: ${object.toString()}', tag: 'Network');
        },
      ),
    );

    // 添加认证拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 获取认证令牌
        final token = _tokenManager.getAccessToken();
        if (token != null && token.isNotEmpty) {
          // 将令牌添加到请求头
          options.headers['Authorization'] = 'Bearer $token';
        }
        log.i('开始请求: ${options.method} ${options.path}', tag: 'API');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log.i(
            '请求成功: ${response.requestOptions.path}, 状态码: ${response.statusCode}',
            tag: 'API');
        return handler.next(response);
      },
      onError: (error, handler) async {
        // 处理401未授权错误
        if (error.response?.statusCode == 401) {
          log.w('认证失败，令牌可能已过期', tag: 'API');
          // 只清除令牌，不处理业务逻辑
          await _tokenManager.clearTokens();
          // 401处理逻辑应该由上层业务处理
        }
        log.e(
          '请求失败: ${error.requestOptions.path}',
          error: error.error,
          tag: 'API',
        );
        return handler.next(error);
      },
    ));
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// 无需认证的专用方法
  /// 无需认证的POST请求
  @override
  Future<Response<T>> postWithoutAuth<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    // 创建不包含Authorization头的选项
    final options = Options(headers: {..._dio.options.headers});
    options.headers?.remove('Authorization');

    log.i('发起无认证请求: POST $path', tag: 'API');

    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// 无需认证的GET请求
  @override
  Future<Response<T>> getWithoutAuth<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    // 创建不包含Authorization头的选项
    final options = Options(headers: {..._dio.options.headers});
    options.headers?.remove('Authorization');

    log.i('发起无认证请求: GET $path', tag: 'API');

    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
