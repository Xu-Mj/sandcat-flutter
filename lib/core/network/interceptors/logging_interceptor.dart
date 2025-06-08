import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

@injectable
class LoggingInterceptor extends Interceptor {
  final Talker _talker;

  LoggingInterceptor(this._talker);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    _talker.info('REQUEST[${options.method}] => PATH: $requestPath');

    if (options.queryParameters.isNotEmpty) {
      _talker.debug('REQUEST QUERY => ${options.queryParameters}');
    }

    if (options.data != null) {
      _talker.debug('REQUEST DATA => ${_formatRequestData(options.data)}');
    }

    if (options.headers.isNotEmpty) {
      _talker.debug(
          'REQUEST HEADERS => ${_redactSensitiveHeaders(options.headers)}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _talker.info(
      'RESPONSE[${response.statusCode}] => '
      'PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
    );

    if (response.data != null) {
      _talker.debug('RESPONSE DATA => ${_formatResponseData(response.data)}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _talker.error(
      'ERROR[${err.response?.statusCode}] => '
      'PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}',
      err.message,
    );

    if (err.response?.data != null) {
      _talker.error('ERROR DATA => ${err.response?.data}');
    }

    handler.next(err);
  }

  String _formatRequestData(dynamic data) {
    if (data is FormData) {
      final formDataMap = <String, dynamic>{};
      for (final field in data.fields) {
        formDataMap[field.key] = field.value;
      }
      for (final file in data.files) {
        formDataMap[file.key] = '(File: ${file.value.filename})';
      }
      return json.encode(formDataMap);
    } else if (data is Map || data is List) {
      return json.encode(data);
    }
    return data.toString();
  }

  String _formatResponseData(dynamic data) {
    if (data is Map || data is List) {
      try {
        return json.encode(data);
      } catch (_) {
        return data.toString();
      }
    }
    return data.toString();
  }

  Map<String, dynamic> _redactSensitiveHeaders(Map<String, dynamic> headers) {
    final redactedHeaders = Map<String, dynamic>.from(headers);
    final sensitiveHeaders = ['authorization', 'cookie'];

    for (final header in sensitiveHeaders) {
      if (redactedHeaders.containsKey(header)) {
        redactedHeaders[header] = '***REDACTED***';
      }
    }

    return redactedHeaders;
  }
}
