import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../chat/chat_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String chatRoute = '/';
}

class AppNavigation {
  AppNavigation._();

  static final GoRouter router =
      GoRouter(initialLocation: Routes.chatRoute, routes: [
    GoRoute(
      path: Routes.chatRoute,
      builder: (context, state) {
        return const ChatView();
      },
    ),
  ]);
}

CustomTransitionPage buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
            opacity:
                CurveTween(curve: Curves.easeInToLinear).animate(animation),
            child: child),
  );
}
