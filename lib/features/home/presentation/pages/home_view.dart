import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project/injection.dart' as di;

import 'package:project/features/home/presentation/bloc/home_view_event.dart';
import 'package:project/features/home/presentation/bloc/home_view_bloc.dart';
import 'package:project/features/home/presentation/bloc/home_view_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeViewNavs = di.locator<HomeViewBloc>().homeViewNavs;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewBloc, HomeViewState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is HomeViewHasData && state.homeView.page is Widget
              ? state.homeView.page as Widget
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          bottomNavigationBar: state is HomeViewHasData && homeViewNavs.length > 1
              ? NavigationBar(
                  selectedIndex: state.homeView.currentPageIndex,
                  onDestinationSelected: (int value) {
                    context.read<HomeViewBloc>().add(OnPageChanged(value));
                  },
                  destinations: homeViewNavs.map((e) => e.navBar).toList(),
                )
              : null,
        );
      },
    );
  }
}
