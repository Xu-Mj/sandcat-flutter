import 'dart:io';
import 'package:flutter/foundation.dart';

/// 设备工具类，提供设备相关信息和功能
class DeviceUtils {
  /// 是否是移动设备（iOS或Android）
  static bool get isMobile {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }

  /// 是否是桌面设备（Windows, macOS, Linux）
  static bool get isDesktop {
    if (kIsWeb) return false;
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  /// 获取设备唯一标识符
  /// 注意：这是简化实现，实际应用中应使用更可靠的方法
  static Future<String> getDeviceId() async {
    // 这里应该实现一个实际的设备ID获取逻辑
    // 通常使用device_info_plus或类似包获取
    if (kIsWeb) {
      return 'web-${DateTime.now().millisecondsSinceEpoch}';
    } else if (Platform.isAndroid) {
      return 'android-${DateTime.now().millisecondsSinceEpoch}';
    } else if (Platform.isIOS) {
      return 'ios-${DateTime.now().millisecondsSinceEpoch}';
    } else if (Platform.isWindows) {
      return 'windows-${DateTime.now().millisecondsSinceEpoch}';
    } else if (Platform.isMacOS) {
      return 'macos-${DateTime.now().millisecondsSinceEpoch}';
    } else if (Platform.isLinux) {
      return 'linux-${DateTime.now().millisecondsSinceEpoch}';
    } else {
      return 'unknown-${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  /// 获取平台名称
  static String getPlatformName() {
    if (kIsWeb) {
      return 'Web';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }
}
