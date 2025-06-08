import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:im_flutter/app/config/api_config.dart';
import 'package:im_flutter/core/services/logger_service.dart';
import 'api_client.dart';

@LazySingleton(as: ApiClient)
class DioClient implements ApiClient {
  final Dio _dio;

  DioClient()
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

    // 注册请求开始和结束的回调
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log.i('开始请求: ${options.method} ${options.path}', tag: 'API');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log.i(
            '请求成功: ${response.requestOptions.path}, 状态码: ${response.statusCode}',
            tag: 'API');
        return handler.next(response);
      },
      onError: (error, handler) {
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
}
