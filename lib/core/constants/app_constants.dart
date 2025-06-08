/// Application-wide constants
class AppConstants {
  // App info
  static const String appName = 'SandCat';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userProfileKey = 'user_profile';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Pagination
  static const int defaultPageSize = 20;

  // UI constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultIconSize = 24.0;

  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 350);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Cache durations
  static const Duration defaultCacheDuration = Duration(hours: 1);
  static const Duration longCacheDuration = Duration(days: 1);

  // Feature flags
  static const bool enableEndToEndEncryption = true;
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  static const bool enableReadReceipts = true;
  static const bool enableTypingIndicators = true;

  // Do not instantiate
  AppConstants._();
}
