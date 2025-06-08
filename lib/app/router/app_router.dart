import 'package:go_router/go_router.dart';
import 'package:im_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:im_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:im_flutter/features/chat/presentation/pages/chat_room_page.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../shared/presentation/pages/splash_page.dart';

/// 应用程序路由配置
class AppRouter {
  /// 创建路由器
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/chat/:id',
          builder: (context, state) {
            final chatId = state.pathParameters['id']!;
            return ChatRoomPage(chatId: chatId);
          },
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    );
  }
}
