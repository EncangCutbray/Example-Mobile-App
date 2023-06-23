import 'package:equatable/equatable.dart';

class HomeViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnPageChanged extends HomeViewEvent {
  final int selectedIndex;

  OnPageChanged(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class OnPageLoaded extends OnPageChanged {
  OnPageLoaded(super.selectedIndex);
 
}
