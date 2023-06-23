import 'package:get_it/get_it.dart';
import 'package:project/features/home/presentation/bloc/home_view_bloc.dart';

class HomeInjection {
  GetIt locator;

  HomeInjection({required this.locator}) {
    // bloc
    locator.registerFactory(() => HomeViewBloc());

    // usecase

    // data source

    // repository
  }
}
