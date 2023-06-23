import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class HomeViewEntity extends Equatable {
  final int currentPageIndex;
  final Widget? page;

  const HomeViewEntity({this.currentPageIndex = 0, this.page});

  @override
  List<Object?> get props => [currentPageIndex, page];
}
