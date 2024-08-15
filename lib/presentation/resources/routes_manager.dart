import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../splash/splash_view.dart';

class Routes {
  static const String splash = '/';
}

class AppNavigation {
  AppNavigation._();

  static final GoRouter router = GoRouter(
      initialLocation: Routes.splash,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) {
            return const SplashView();
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
