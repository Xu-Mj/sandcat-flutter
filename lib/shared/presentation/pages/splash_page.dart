import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:im_flutter/ui/auth/presentation/providers/auth_provider.dart';

/// Splash screen shown when the app starts
class SplashPage extends ConsumerStatefulWidget {
  /// Creates a splash page
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 1));

    // 检查认证状态提供者中的状态
    final authState = ref.read(authStateProvider);

    if (mounted) {
      if (authState.state == AuthState.authenticated) {
        context.go('/home');
      } else {
        context.go('/login');
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
