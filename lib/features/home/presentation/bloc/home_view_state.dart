import 'package:equatable/equatable.dart';
import 'package:project/features/home/domain/entities/home_view_entity.dart';

abstract class HomeViewState extends Equatable {
  const HomeViewState();

  @override
  List<Object?> get props => [];
}

class HomeViewEmpty extends HomeViewState {
  @override
  List<Object?> get props => [];
}

class HomeViewHasData extends HomeViewState {
  final HomeViewEntity homeView;

  const HomeViewHasData(this.homeView);

  @override
  List<Object?> get props => [homeView];
}
