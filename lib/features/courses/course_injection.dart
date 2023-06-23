import 'package:get_it/get_it.dart';
import 'package:project/features/courses/domain/usecases/course_list_54_use_case.dart';

import 'package:project/features/courses/presentation/bloc/course_bloc.dart';
import 'package:project/features/courses/data/datasources/course_list_54_data_source.dart';
import 'package:project/features/courses/data/repositories/course_list_54_respository_impl.dart';
import 'package:project/features/courses/domain/respositories/course_list_54_respository.dart';

class CourseInjection {
  GetIt locator;

  CourseInjection({required this.locator}) {
    // bloc
    locator.registerFactory(() => CourseBloc(locator()));

    // usecase
    locator.registerLazySingleton(() => CourseList54UseCase(locator()));

    // data source
    locator.registerLazySingleton<CourseList54DataSource>(
      () => CourseList54DataSourceImpl(client: locator()),
    );

    // repository
    locator.registerLazySingleton<CourseList54Repository>(
      () => CourseList54RepositoryImpl(courseList54DataSource: locator()),
    );
  }
}
