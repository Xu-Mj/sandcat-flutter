import 'package:flutter/cupertino.dart';

/// App theme configuration
class AppTheme {
  /// Light theme for the app
  static CupertinoThemeData get lightTheme => const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
        primaryContrastingColor: CupertinoColors.white,
        barBackgroundColor: CupertinoColors.systemBackground,
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.systemBlue,
          textStyle: TextStyle(
            color: CupertinoColors.label,
            fontSize: 16,
            fontFamily: 'SF Pro',
          ),
          actionTextStyle: TextStyle(
            color: CupertinoColors.systemBlue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro',
          ),
          navTitleTextStyle: TextStyle(
            color: CupertinoColors.label,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro',
          ),
          navLargeTitleTextStyle: TextStyle(
            color: CupertinoColors.label,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            fontFamily: 'SF Pro',
          ),
          tabLabelTextStyle: TextStyle(
            color: CupertinoColors.systemBlue,
            fontSize: 10,
            fontFamily: 'SF Pro',
          ),
        ),
      );

  /// Dark theme for the app
  static CupertinoThemeData get darkTheme => const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemBlue,
        primaryContrastingColor: CupertinoColors.black,
        barBackgroundColor: CupertinoColors.systemBackground,
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.systemBlue,
          textStyle: TextStyle(
            color: CupertinoColors.label,
            fontSize: 16,
            fontFamily: 'SF Pro',
          ),
          actionTextStyle: TextStyle(
            color: CupertinoColors.systemBlue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro',
          ),
          navTitleTextStyle: TextStyle(
            color: CupertinoColors.label,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro',
          ),
          navLargeTitleTextStyle: TextStyle(
            color: CupertinoColors.label,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            fontFamily: 'SF Pro',
          ),
          tabLabelTextStyle: TextStyle(
            color: CupertinoColors.systemBlue,
            fontSize: 10,
            fontFamily: 'SF Pro',
          ),
        ),
      );
}
