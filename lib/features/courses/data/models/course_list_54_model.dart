import 'package:equatable/equatable.dart';
import 'package:project/features/courses/domain/entities/course.dart';

class CourseList54Model extends Equatable {

  const CourseList54Model({required this.result});

  final List<dynamic> result;

  @override
  List<Object?> get props => [result];

  @override
  bool? get stringify => true;

  List<Course> toCoursesList () {
    return result.map((e) => Course.fromJson(e)).toList();
  }
}
