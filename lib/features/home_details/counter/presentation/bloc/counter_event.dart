part of 'counter_bloc.dart';

class CounterEvent extends Equatable {
  final int counter;

  const CounterEvent(this.counter);

  @override
  List<Object?> get props => [counter];
}

class CounterStarted extends CounterEvent {
  const CounterStarted() : super(0);
}

class CounterIncrementPressed extends CounterEvent {
  const CounterIncrementPressed(super.counter);
}

class CounterDecrementPressed extends CounterEvent {
  const CounterDecrementPressed(super.counter);
}
