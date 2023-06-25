import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:project/features/home/presentation/pages/home_view.dart';
import 'package:project/features/blank/presentation/pages/blank_page.dart';
import 'package:project/features/courses/presentation/pages/course_page.dart';
import 'package:project/features/home_details/counter/presentation/pages/counter_page.dart';
import 'package:project/features/home_details/timer/presentation/pages/timer_page.dart';

class Routes extends GoRouter {
  final List<RouteBase> routesApp;

  GlobalKey<NavigatorState>? keyNavigatorApp;

  final String? initialLocationApp;

  Routes({required this.routesApp, this.keyNavigatorApp, this.initialLocationApp})
      : super(routes: routesApp, navigatorKey: keyNavigatorApp, initialLocation: initialLocationApp);

  factory Routes.app() {
    final keyNavigatorApp = GlobalKey<NavigatorState>();

    // ignore: unused_local_variable
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return Routes(
      keyNavigatorApp: keyNavigatorApp,
      initialLocationApp: '/',
      routesApp: [
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
              ),
              GoRoute(
                path: 'home/counter',
                builder: (BuildContext context, GoRouterState state) {
                  return const CounterPage(
                    title: 'Counter Page',
                  );
                },
              ),
              GoRoute(
                path: 'home/timer',
                builder: (BuildContext context, GoRouterState state) {
                  return const TimerPage(
                    title: 'Time Page',
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
      ],
    );
  }
}
