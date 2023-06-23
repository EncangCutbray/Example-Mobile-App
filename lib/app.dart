// ignore_for_file: dead_code
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project/features/home/presentation/bloc/home_view_bloc.dart';
import 'package:project/features/home/presentation/bloc/home_view_event.dart';
import 'package:project/features/courses/presentation/bloc/course_bloc.dart';

import 'package:project/routers.dart';
import 'package:go_router/go_router.dart';
import 'package:project/injection.dart' as di;
import 'package:project/core/cubit/route_cubit.dart';
import 'package:project/core/widgets/navigation_bar_app.dart';
import 'package:project/counter/cubit/counter_cubit.dart';
import 'package:project/counter/view/counter_page_view.dart';
import 'package:project/courses/cubit/course_cubit.dart';
import 'package:project/courses/models/course_model.dart';
import 'package:project/courses/view/course_view.dart';
import 'package:project/example/example_view.dart';

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
                    child: ExampleView(
                  title: "Blank 1",
                )),
              ),
              GoRoute(
                path: '/blank-2',
                pageBuilder: (context, state) => const NoTransitionPage(
                    child: ExampleView(title: "Blank 2")),
              )
            ],
          ),
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const CourseView();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) {
                  return const CounterPageView();
                },
              ),
            ],
          )
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
          BlocProvider<CounterCubit>(
            create: (BuildContext context) => CounterCubit(0),
          ),
          BlocProvider<CourseCubit>(
            create: (BuildContext context) => CourseCubit(
                CourseModel.fromJson(const {'result': null, 'counter': 0}))
              ..getCourses54(),
          ),
          BlocProvider<RouteCubit>(create: (BuildContext context) {
            return RouteCubit(RoutesModel.fromJson({}))..routes();
          }),
          BlocProvider(
            create: (BuildContext context) {
              // return di.locator<CourseBloc>()..add(const OnCourseLoaded());
              return di.locator<CourseBloc>();
            },
          ),
          BlocProvider(
            create: (_) => di.locator<HomeViewBloc>()..add(OnPageLoaded(1)),
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
