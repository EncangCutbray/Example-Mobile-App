import 'package:dartz/dartz.dart';
import 'package:project/exceptions/failure.dart';
import 'package:project/features/courses/domain/entities/course.dart';
import 'package:project/features/courses/domain/respositories/course_list_54_respository.dart';

class CourseList54UseCase {
  
  CourseList54Repository repository;

  CourseList54UseCase(this.repository);

  Future<Either<Failure, List<Course>>> courseList54execute() {
    return repository.getCourseList54();
  }
}
