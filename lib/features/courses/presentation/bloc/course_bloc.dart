import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/courses/presentation/bloc/course_event.dart';
import 'package:project/features/courses/presentation/bloc/course_state.dart';
import 'package:project/features/courses/domain/usecases/course_list_54_use_case.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseList54UseCase _courseList54UseCase;

  CourseBloc(this._courseList54UseCase) : super(CourseEmpty()) {
    on<OnCourseLoaded>(
      (event, emit) async {

        emit(CourseLoading());

        final result = await _courseList54UseCase.courseList54execute();

        result.fold(
          (failure) {
            emit(CourseError(failure.message));
          },
          (data) {
            emit(CourseHasData(result: data, forceRefresh: event.forceRefresh));
          },
        );
      },
      transformer: debounce(Duration.zero),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
