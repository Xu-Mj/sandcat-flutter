import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sandcat/ui/auth/presentation/providers/auth_provider.dart';

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

    // 确保组件仍然挂载，否则不继续执行
    if (!mounted) return;

    // 检查认证状态提供者中的状态
    final authState = ref.read(authStateProvider);

    if (authState.state == AuthState.authenticated) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/sandcat_logo.svg',
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  CupertinoColors.systemBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // App name
            const Text(
              'SandCat',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),

            // Loading indicator
            const CupertinoActivityIndicator(radius: 16),
          ],
        ),
      ),
    );
  }
}
