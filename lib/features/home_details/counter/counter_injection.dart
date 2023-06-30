import 'package:get_it/get_it.dart';
import 'package:project/features/home_details/counter/presentation/bloc/counter_bloc.dart';


class CounterInjection {
  GetIt locator;

  CounterInjection({required this.locator}) {
    // bloc
    locator.registerFactory(() => CounterBloc());

     // usecase

    // usecase

    // data source

    // repository
  }
}
