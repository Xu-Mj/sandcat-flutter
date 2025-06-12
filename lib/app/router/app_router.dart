import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:im_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:im_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:im_flutter/features/chat/presentation/pages/chat_room_page.dart';
import 'package:im_flutter/features/contacts/presentation/pages/create_friend_page.dart';
import 'package:im_flutter/features/contacts/presentation/pages/friend_detail_page.dart';
import 'package:im_flutter/features/contacts/presentation/pages/friend_requests_page.dart';
import 'package:im_flutter/features/home/presentation/pages/home_page.dart';
import 'package:im_flutter/shared/presentation/pages/splash_page.dart';

// 添加GoRouter刷新流，用于监听状态变化
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// 应用程序路由配置
class AppRouter {
  /// 创建路由器
  static GoRouter createRouter(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable:
          GoRouterRefreshStream(ref.read(authStateProvider.notifier).stream),
      redirect: (BuildContext context, GoRouterState state) {
        final authState = ref.read(authStateProvider);
        final isLoggedIn = authState.state == AuthState.authenticated;

        // 登录相关页面
        final isAuthRoute = state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/';

        // 如果未登录且不在认证相关页面，重定向到登录页
        if (!isLoggedIn && !isAuthRoute) {
          return '/login';
        }

        // 如果已登录且在登录/注册页，重定向到首页
        if (isLoggedIn &&
            (state.matchedLocation == '/login' ||
                state.matchedLocation == '/register')) {
          return '/home';
        }

        // 其他情况不重定向
        return null;
      },
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
            return ChatRoomPage(chatId: chatId, key: ValueKey('chat_$chatId'));
          },
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        // 联系人相关路由
        GoRoute(
          path: '/contacts/add',
          builder: (context, state) => const CreateFriendPage(),
        ),
        GoRoute(
          path: '/contacts/requests',
          builder: (context, state) => const FriendRequestsPage(),
        ),
        GoRoute(
          path: '/contacts/detail/:id',
          builder: (context, state) {
            final friendId = state.pathParameters['id']!;
            return FriendDetailPage(friendId: friendId);
          },
        ),
      ],
    );
  }
}
