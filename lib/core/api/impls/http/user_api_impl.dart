import 'package:dio/dio.dart';
import 'package:sandcat/core/api/user.dart';
import 'package:sandcat/core/models/user/auth_token.dart';
import 'package:sandcat/core/models/user/login_request.dart';
import 'package:sandcat/core/models/user/user_model.dart';
import 'package:sandcat/core/network/api_client.dart';
import 'package:injectable/injectable.dart';

/// UserApi的HTTP实现
@LazySingleton(as: UserApi)
class UserApiHttpImpl implements UserApi {
  final ApiClient _apiClient;

  /// 构造函数
  UserApiHttpImpl(this._apiClient);

  @override
  Future<Response> refreshToken(String token, bool isRefresh) {
    return _apiClient.get('/user/refresh_token/$token/$isRefresh');
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String code,
    String? avatar,
  }) {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'code': code,
      'avatar': avatar,
    };
    return _apiClient.postWithoutAuth('/user', data: data).then((response) {
      return UserModel.fromJson(response.data);
    });
  }

  @override
  Future<Response> updateUser({
    required String id,
    String? name,
    String? avatar,
    String? signature,
    String? gender,
    String? region,
    int? age,
  }) {
    final data = {
      'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      'signature': signature,
      if (gender != null) 'gender': gender,
      if (region != null) 'region': region,
      if (age != null) 'age': age,
    };
    return _apiClient.put('/user', data: data);
  }

  @override
  Future<Response> searchUser(String userId, String pattern) {
    return _apiClient.get('/user/$userId/search/$pattern');
  }

  @override
  Future<Response> logout(String uuid) {
    return _apiClient.delete('/user/logout/$uuid');
  }

  @override
  Future<AuthToken> login(LoginRequest request) {
    return _apiClient
        .postWithoutAuth('/user/login', data: request.toJson())
        .then((response) {
      return AuthToken.fromJson(response.data);
    });
  }

  @override
  Future<Response> modifyPassword({
    required String userId,
    required String email,
    required String pwd,
    required String code,
  }) {
    final data = {
      'user_id': userId,
      'email': email,
      'pwd': pwd,
      'code': code,
    };
    return _apiClient.put('/user/pwd', data: data);
  }

  @override
  Future<Response> sendRegisterCode(String email) {
    final data = {
      'email': email,
    };
    return _apiClient.postWithoutAuth('/user/mail/send', data: data);
  }
}
