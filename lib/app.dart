// ignore_for_file: dead_code
import 'package:project/features/courses/presentation/bloc/course_event.dart';
import 'package:project/features/home_details/counter/presentation/bloc/counter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home_details/timer/presentation/bloc/timer_bloc.dart';
import 'package:project/features/home/presentation/bloc/home_view_bloc.dart';
import 'package:project/features/home/presentation/bloc/home_view_event.dart';
import 'package:project/features/courses/presentation/bloc/course_bloc.dart';

import 'package:project/features/blank/presentation/pages/blank_page.dart';

import 'package:project/routers.dart';
import 'package:go_router/go_router.dart';
import 'package:project/injection.dart' as di;
import 'package:project/core/cubit/route_cubit.dart';
import 'package:project/core/widgets/navigation_bar_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  final bool isCoursePage = true;

  GoRouter _buildRouter() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    return GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: '/',
        routes: <RouteBase>[
          ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (context, state, child) {
              return NavigationBarApp(child: child);
            },
            routes: [
              GoRoute(
                path: '/blank-1',
                pageBuilder: (context, state) => const NoTransitionPage(
                    child: BlankPage(
                  title: "Blank 1",
                )),
              ),
              GoRoute(
                path: '/blank-2',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: BlankPage(title: "Blank 2")),
              )
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    /// 1. Material App
    /**
      return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: isCounterPage ? const CounterPage() : const CoursePage(),
    );
     */

    return Sizer(builder: (context, orientation, deviceType) {
      /// Multiple Bloc In Root Application
      return MultiBlocProvider(
        providers: [
          BlocProvider<RouteCubit>(
            create: (BuildContext context) =>
                RouteCubit(RoutesModel.fromJson({}))..routes(),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                true ? di.locator<CourseBloc>() : di.locator<CourseBloc>()
                  ..add(const OnCourseLoaded()),
          ),
          BlocProvider(
            create: (_) => di.locator<HomeViewBloc>()..add(OnPageLoaded(0)),
          ),
          BlocProvider(
            create: (_) => di.locator<CounterBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TimerBloc>(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: true ? Routes.app() : _buildRouter(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      );
    });
  }
}
