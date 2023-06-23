import 'package:equatable/equatable.dart';
import 'package:project/features/courses/domain/entities/course.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseEmpty extends CourseState {}

class CourseLoading extends CourseState {}

class CourseError extends CourseState {
  final String message;

  const CourseError(this.message);

  @override
  List<Object?> get props => [message];
}

class CourseHasData extends CourseState {
  final bool forceRefresh;
  final List<Course> result;

  const CourseHasData({required this.result, this.forceRefresh = false});

  @override
  List<Object?> get props => [result];
}

class CourseHasData2 extends CourseState {
  final Course result;

  const CourseHasData2(this.result);

  @override
  List<Object?> get props => [result];
}