import 'package:equatable/equatable.dart';

class CounterEntity extends Equatable {
  final int counterValue;

  const CounterEntity(this.counterValue);

  @override
  List<Object?> get props => [counterValue];
}
