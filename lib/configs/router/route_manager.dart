import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/books/presentation/ui/pages/books_page.dart';
import '../../shared/presentation/ui/pages/error_page.dart';

class RouteManager {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/home',
          name: RouteConfig.homeRouteName,
          pageBuilder: (context, state) {
            // Params indicates whether the page is the favorites page or not
            return _buildPage(page: BooksPage(params: false), state: state);
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'favorites',
              name: RouteConfig.favoritesRouteName,
              pageBuilder: (context, state) {
                return _buildPage(page: BooksPage(params: true), state: state);
              },
            ),
          ]),
    ],
    errorPageBuilder: (context, state) {
      return _buildPage(page: const ErrorPage(), state: state);
    },
  );

  static GoRouter get router => _router;

  static Page _buildPage({
    required Widget page,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          _buildTransition(animation, child),
      child: page,
    );
  }

  static Widget _buildTransition(Animation animation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

abstract class RouteConfig {
  static const homeRouteName = 'home';
  static const favoritesRouteName = 'favorites';
}
