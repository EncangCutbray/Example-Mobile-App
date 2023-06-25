import 'package:equatable/equatable.dart';

class TimerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TimerStarted extends TimerEvent {
  TimerStarted({required this.duration});
  final int duration;
}

final class TimerPaused extends TimerEvent {
  TimerPaused();
}

final class TimerResumed extends TimerEvent {
  TimerResumed();
}

class TimerReset extends TimerEvent {
  TimerReset();
}

// ignore: unused_element
class TimerTicked extends TimerEvent {
  TimerTicked({required this.duration});
  final int duration;
}


