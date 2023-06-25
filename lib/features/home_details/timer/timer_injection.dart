import 'package:get_it/get_it.dart';
import 'package:project/features/home_details/timer/presentation/bloc/timer_bloc.dart';
import 'package:project/features/home_details/timer/domain/usecases/ticker_usecase.dart';

class TimerInjection {
  GetIt locator;

  TimerInjection({required this.locator}) {
    // bloc
    locator.registerFactory(() => TimerBloc(ticker: locator()));

     // usecase
    locator.registerLazySingleton(() => const TickerUseCase());

    // usecase

    // data source

    // repository
  }
}
