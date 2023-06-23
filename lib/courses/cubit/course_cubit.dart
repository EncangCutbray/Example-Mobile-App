import 'package:bloc/bloc.dart';
import 'package:project/core/services/http_service.dart';
import 'package:project/courses/models/course_model.dart';

class CourseCubit extends Cubit<CourseModel> {
  HttpService? backend;

  CourseCubit(super.initialState) {
    backend = HttpService();
  }

  /// Add 1 to the current state.
  Future<void> getCourses54() async {
    var endPoint = '/courses/content/54';
    final response = await backend?.httpGet(endPoint);
    emit(
      CourseModel.fromJson({'result': response?.body, 'counter': state.counter}),
    );
  }

  void increment() => emit(CourseModel.fromJson(
        {'result': state.result, 'counter': state.counter! + 1},
      ));
  void decrement() => emit(CourseModel.fromJson(
        {'result': state.result, 'counter': state.counter! - 1},
      ));

}
