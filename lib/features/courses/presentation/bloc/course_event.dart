import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class OnCourseLoaded extends CourseEvent {

final bool forceRefresh;

  const OnCourseLoaded({this.forceRefresh = false});

  @override
  List<Object?> get props => [];
}