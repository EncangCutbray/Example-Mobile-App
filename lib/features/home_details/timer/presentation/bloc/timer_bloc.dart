import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project/features/home_details/timer/domain/usecases/ticker_usecase.dart';
import 'package:project/features/home_details/timer/presentation/bloc/timer_event.dart';
import 'package:project/features/home_details/timer/presentation/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final TickerUseCase _ticker;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required TickerUseCase ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    print('Bloc Close');
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : const TimerRunComplete(),
    );
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    print(event.duration);
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen(
          (duration) => add(TimerTicked(duration: duration)),
        );
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  // void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {}
}
