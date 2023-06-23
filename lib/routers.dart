import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:project/features/home/presentation/pages/home_view.dart';
import 'package:project/features/blank/presentation/pages/blank_page.dart';
import 'package:project/features/courses/presentation/pages/course_page.dart';

class Routes extends GoRouter {
  final List<RouteBase> routesApp;

  GlobalKey<NavigatorState>? keyNavigatorApp;

  Routes({required this.routesApp, this.keyNavigatorApp})
      : super(routes: routesApp, navigatorKey: keyNavigatorApp);

  factory Routes.app() {
    final keyNavigatorApp = GlobalKey<NavigatorState>();

    // ignore: unused_local_variable
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return Routes(keyNavigatorApp: keyNavigatorApp, routesApp: [
      // ShellRoute(navigatorKey: shellNavigatorKey, routes: const <RouteBase>[]),

      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeView();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'home/banner',
              builder: (BuildContext context, GoRouterState state) {
                return const BlankPage(
                  title: 'Home Banner',
                );
              },
            ),
            GoRoute(
              path: 'home/flag',
              builder: (BuildContext context, GoRouterState state) {
                return const BlankPage(
                  title: 'Home Flag',
                );
              },
            )
          ]),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const CoursePage();
        },
      )
    ]);
  }
}
