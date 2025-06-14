import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandcat/core/models/user/register_request.dart';
import 'package:sandcat/core/models/user/user_model.dart';
import 'package:sandcat/ui/auth/data/repositories/auth_repository.dart';

/// 注册控制器
class RegisterController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  // 倒计时相关变量
  int _countdownSeconds = 0;
  Timer? _countdownTimer;
  final ValueNotifier<int> countdownNotifier = ValueNotifier<int>(0);

  /// 创建控制器
  RegisterController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AsyncData<void>(null));

  /// 发送验证码
  Future<void> sendCode(String email) async {
    if (_countdownSeconds > 0) return;

    state = const AsyncLoading();
    try {
      await _authRepository.sendRegisterCode(email);
      _startCountdown();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 注册用户
  Future<UserModel?> register({
    required String name,
    required String email,
    required String code,
    required String password,
    String? avatar,
  }) async {
    state = const AsyncLoading();
    try {
      final user = await _authRepository.register(RegisterRequest(
        name: name,
        email: email,
        code: code,
        password: password,
        avatar: avatar,
      ));
      state = const AsyncData(null);
      return user;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  // 开始倒计时
  void _startCountdown() {
    _countdownSeconds = 60;
    countdownNotifier.value = _countdownSeconds;

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
          countdownNotifier.value = _countdownSeconds;
        } else {
          _countdownTimer?.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    countdownNotifier.dispose();
    super.dispose();
  }
}
