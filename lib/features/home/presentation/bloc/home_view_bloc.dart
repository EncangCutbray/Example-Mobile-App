import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project/features/blank/presentation/pages/blank_page.dart';
import 'package:project/features/home/domain/entities/home_nav_entitiy.dart';
import 'package:project/features/home/domain/entities/home_view_entity.dart';

import 'package:project/features/home/presentation/bloc/home_view_event.dart';
import 'package:project/features/home/presentation/bloc/home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  
  final List<HomeNavEntity> homeViewNavs = HomeNavEntity.homeViewNavs();

  final Widget pageNotFound = const BlankPage();

  HomeViewBloc() : super(HomeViewEmpty()) {
    on<OnPageLoaded>(_pageChange);
    on<OnPageChanged>(_pageChange);
  }

  void _pageChange(event, emit) {
    // selected index
    int selectedIndex = event.selectedIndex;

    // find page
    Widget page = homeViewNavs.asMap().containsKey(selectedIndex)
        ? homeViewNavs.elementAt(selectedIndex).page
        : pageNotFound;

    emit(
      HomeViewHasData(
        HomeViewEntity(currentPageIndex: selectedIndex, page: page),
      ),
    );
  }
}
