import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project/core/models/model.dart';

class RoutesModel implements Model {
  List<RouteModel>? route;

  RoutesModel({this.route});

  RoutesModel.fromJson(Map<String, dynamic> json) {
    if (json['route'] != null) {
      route = <RouteModel>[];
      json['route'].forEach((v) {
        route!.add(RouteModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (route != null) {
      data['route'] = route!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RouteModel implements Model{
  Widget? selectedIcon;
  Widget? icon;
  String? label;

  RouteModel({this.selectedIcon, required this.icon, required this.label});

  RouteModel.fromJson(Map<String, dynamic> json) {
    RouteModel(
      icon: json['icon'] as Widget,
      label: json['label'] as String,
      selectedIcon: json['selectedIcon'] as Widget,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedIcon'] = selectedIcon;
    data['icon'] = icon;
    data['label'] = label;
    return data;
  }
}

class RouteCubit extends Cubit<RoutesModel> {
  RouteCubit(super.initialState);

  /// Add 1 to the current state.
  void routes() => emit(
        RoutesModel.fromJson(
          {
            'route': [
              {
                'selectedIcon': const Icon(Icons.book),
                'icon': const Icon(Icons.book_outlined),
                'label': 'Learn'
              },
              {
                'selectedIcon': const Icon(Icons.engineering),
                'icon': const Icon(Icons.engineering_outlined),
                'label': 'Relearn'
              },
              {
                'selectedIcon': const Icon(Icons.bookmark),
                'icon': const Icon(Icons.bookmark_border),
                'label': 'Unlearn'
              },
            ]
          },
        ),
      );
}
