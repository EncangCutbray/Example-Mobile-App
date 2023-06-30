import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/features/home_details/counter/domain/entities/counter_entity.dart';

part 'counter_state.dart';
part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial(CounterEntity(0))) {
    on<CounterIncrementPressed>((event, emit) {
      final counter = state.totalCounter.counterValue + event.counter;
      // emit(state.copyWith(counter));
      emit(CounterIncrement(state.copyWith(counter).totalCounter));
    });
    on<CounterDecrementPressed>((CounterDecrementPressed event, emit) {
      final counter = state.totalCounter.counterValue - event.counter;
      // emit(state.copyWith(counter));
      emit(CounterDecrement(state.copyWith(counter).totalCounter));
    });
  }
}
