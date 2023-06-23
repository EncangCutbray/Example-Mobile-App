import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/cubit/route_cubit.dart';

class NavigationBarApp extends StatefulWidget {
  final Widget? child;

  const NavigationBarApp({super.key, this.child});

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  int selectedPageIndex = 0;

  void onNavTap(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  Widget buildNavigationBar(List<RouteModel>? routes) => NavigationBar(
        selectedIndex: selectedPageIndex,
        onDestinationSelected: onNavTap,
        destinations:  const <NavigationDestination>[
          // ...routes!.map((e) => NavigationDestination(
          //     selectedIcon: e.selectedIcon,
          //     icon: e.icon as Widget,
          //     label:  e.label as String,
          //   )).toList(),
          ...[
            NavigationDestination(
              selectedIcon: Icon(Icons.book),
              icon: Icon(Icons.book_outlined),
              label: 'Learn',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.engineering),
              icon: Icon(Icons.engineering_outlined),
              label: 'Relearn',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Unlearn',
            ),
          ],
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteCubit, RoutesModel>(
      buildWhen: (previous, current) => current.route![0].label != null,
      builder: (context, state) {
        if (widget.child != null) {
          return Scaffold(
            body: widget.child,
            bottomNavigationBar: buildNavigationBar(state.route),
          );
        } else {
          return buildNavigationBar(state.route);
        }
      },
    );
  }
}
