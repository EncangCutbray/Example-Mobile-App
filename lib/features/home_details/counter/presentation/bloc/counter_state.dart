part of 'counter_bloc.dart';

class CounterState extends Equatable {

  const CounterState(this.totalCounter);

  final CounterEntity totalCounter;

  CounterState copyWith(int counter) {
    return CounterState(CounterEntity(counter));
  }

  @override
  List<Object?> get props => [totalCounter];

}

class CounterInitial extends CounterState {
  const CounterInitial(super.totalCounter);
}

class CounterIncrement extends CounterState {
  const CounterIncrement(super.totalCounter);

}

class CounterDecrement extends CounterState {
  const CounterDecrement(super.totalCounter);
}
