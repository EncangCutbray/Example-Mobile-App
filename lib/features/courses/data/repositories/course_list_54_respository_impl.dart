import 'package:dartz/dartz.dart';
import 'package:project/exceptions/failure.dart';
import 'package:project/features/courses/domain/entities/course.dart';
import 'package:project/features/courses/data/datasources/course_list_54_data_source.dart';
import 'package:project/features/courses/domain/respositories/course_list_54_respository.dart';

class CourseList54RepositoryImpl implements CourseList54Repository {
  final CourseList54DataSource courseList54DataSource;

  CourseList54RepositoryImpl({required this.courseList54DataSource});

  @override
  Future<Either<Failure, List<Course>>> getCourseList54() async {
    try {
      final result = await courseList54DataSource.getCourseList54();
      return Right(result.toCoursesList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
