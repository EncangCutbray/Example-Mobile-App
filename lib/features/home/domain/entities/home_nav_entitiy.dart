import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/blank/presentation/pages/blank_page.dart';
import 'package:project/features/mucis/presentation/pages/mucis_page.dart';
import 'package:project/features/voucher/presentation/pages/voucher_page.dart';
import 'package:project/features/purchase/presentation/pages/purchase_page.dart';
import 'package:project/features/courses/presentation/pages/course_page.dart';

class HomeNavEntity extends Equatable {
  final Widget page;
  final NavigationDestination navBar;

  const HomeNavEntity({required this.navBar, required this.page});

  @override
  List<Object?> get props => [page, navBar];

  /// Registration your nav here
  static List<HomeNavEntity> homeViewNavs() {
    return [
      const HomeNavEntity(
        navBar: NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        page: HomePage(),
      ),
      const HomeNavEntity(
        navBar: NavigationDestination(icon: Icon(Icons.music_note), label: 'Music'),
        page: MusicPage(),
      ),
      const HomeNavEntity(
        navBar: NavigationDestination(
          icon: Image(
            image: AssetImage('assets/images/navigation-bars/Purchase_off.png'),
          ),
          selectedIcon: Image(
            image: AssetImage('assets/images/navigation-bars/Purchase_on.png'),
          ),
          label: 'Purchase',
        ),
        page: PurchasePage(),
      ),
      const HomeNavEntity(
        navBar: NavigationDestination(
          icon: Image(
            image: AssetImage('assets/images/navigation-bars/Voucher_off.png'),
          ),
          selectedIcon: Image(
            image: AssetImage('assets/images/navigation-bars/Voucher_on.png'),
          ),
          label: 'Voucher',
        ),
        page: VoucherPage(),
      ),
      const HomeNavEntity(
        navBar:
            NavigationDestination(icon: Icon(Icons.commute), label: 'Commute'),
        page: BlankPage(title: 'Commute',),
      ),
      const HomeNavEntity(
        navBar:
            NavigationDestination(icon: Icon(Icons.book), label: 'Course'),
        page: CoursePage(),
      )
    ];
  }

  static List<HomeNavEntity> exampleHomeViewNavs() {
    return [
      const HomeNavEntity(
        navBar:
            NavigationDestination(icon: Icon(Icons.home), label: 'Example 1'),
        page: BlankPage(title: 'Example 1'),
      ),
      const HomeNavEntity(
        navBar: NavigationDestination(
            icon: Icon(Icons.commute), label: 'Example 2'),
        page: BlankPage(
          title: 'Example 2',
        ),
      ),
    ];
  }
}
