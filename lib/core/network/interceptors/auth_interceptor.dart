import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final _authTokenHeader = 'Authorization';
  String? _accessToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_accessToken != null) {
      options.headers[_authTokenHeader] = 'Bearer $_accessToken';
    }
    handler.next(options);
  }

  void setAccessToken(String? token) {
    _accessToken = token;
  }

  void clearAccessToken() {
    _accessToken = null;
  }
}
