import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Splash screen shown when the app starts
class SplashPage extends StatefulWidget {
  /// Creates a splash page
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 1));

    // Check if user is logged in
    const isLoggedIn = false; // 修改为false，默认跳转登录页面

    if (mounted) {
      if (isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/login'); // 跳转到登录页面
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Icon(
              CupertinoIcons.chat_bubble_2_fill,
              size: 100,
              color: CupertinoColors.systemBlue,
            ),
            SizedBox(height: 24),

            // App name
            Text(
              'SandCat',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 48),

            // Loading indicator
            CupertinoActivityIndicator(radius: 16),
          ],
        ),
      ),
    );
  }
}
