// ignore_for_file: unnecessary_type_check

import 'package:flutter_test/flutter_test.dart';
import 'package:project/features/courses/data/datasources/course_list_54_data_source.dart';
import 'package:project/features/courses/data/models/course_list_54_model.dart';
import 'package:project/features/courses/domain/entities/course.dart';
import 'package:project/injection.dart' as di;

void main() {
  group('Group Course List 54 Data Sources Test', () {
    setUpAll(() {
      di.Injection();
    });

    test('Course List 54 Data Sources Test', () async {
      final dataSources = di.locator<CourseList54DataSource>();
      expect(dataSources is CourseList54DataSourceImpl, true);

      final result = await dataSources.getCourseList54();
      
      expect(result is CourseList54Model, true);
      expect(result.toCoursesList().length > 1, true);
      expect(result.toCoursesList() is List<Course>, true);

    });

    tearDownAll(() {
      di.locator.unregister<CourseList54DataSource>();
    });
  });
  
}
