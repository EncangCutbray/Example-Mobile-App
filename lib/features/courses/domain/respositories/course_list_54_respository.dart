import 'package:dartz/dartz.dart';
import 'package:project/exceptions/failure.dart';
import 'package:project/features/courses/domain/entities/course.dart';

abstract class CourseList54Repository {
    Future<Either<Failure, List<Course>>> getCourseList54();
}