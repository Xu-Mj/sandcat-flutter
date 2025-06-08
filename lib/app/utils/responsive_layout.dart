import 'package:flutter/widgets.dart';

/// 设备类型枚举
enum DeviceType {
  /// 手机
  mobile,

  /// 平板
  tablet,

  /// 桌面
  desktop,
}

/// 响应式布局帮助类
class ResponsiveLayout {
  /// 移动设备的最大宽度
  static const double mobileMaxWidth = 600;

  /// 平板设备的最大宽度
  static const double tabletMaxWidth = 900;

  /// 获取当前设备类型
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < mobileMaxWidth) {
      return DeviceType.mobile;
    } else if (width < tabletMaxWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// 判断是否为移动设备
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// 判断是否为平板设备
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// 判断是否为桌面设备
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// 构建根据设备类型返回不同控件的布局
  static Widget builder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
