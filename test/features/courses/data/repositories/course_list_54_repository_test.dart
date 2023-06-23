// ignore_for_file: unnecessary_type_check

import 'package:project/injection.dart' as di;
import 'package:flutter_test/flutter_test.dart';
import 'package:project/features/courses/domain/entities/course.dart';
import 'package:project/features/courses/data/datasources/course_list_54_data_source.dart';
import 'package:project/features/courses/domain/respositories/course_list_54_respository.dart';
import 'package:project/features/courses/data/repositories/course_list_54_respository_impl.dart';

void main() {
  group('Group Course List 54 Repositories', () {
    setUpAll(() {
      di.Injection();
    });

    test('Course List 54 Repositories getCourseList54', () async {
      final repository = di.locator<CourseList54Repository>();
      expect(repository is CourseList54RepositoryImpl, true);

      final result = await repository.getCourseList54();
      expect(result.all((r) => r is List<Course>), true);
    });

    tearDownAll(() {
      di.locator.unregister<CourseList54DataSource>();
    });
  });
  
}
