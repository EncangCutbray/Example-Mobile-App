import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/home_details/timer/presentation/bloc/timer_bloc.dart';
import 'package:project/features/home_details/timer/presentation/bloc/timer_event.dart';
import 'package:project/features/home_details/timer/presentation/bloc/timer_state.dart';

class TimerPage extends StatelessWidget {
  final String title;

  const TimerPage({super.key, this.title = 'Timer Page'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            begin: Alignment.topRight,
            colors: [Colors.amber, Colors.white],
          ),
        ),
        child: const Stack(
          children: [
            // BackgroundTimer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  child: Center(child: TimerText()),
                ),
                Actions(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundTimer extends StatelessWidget {
  const BackgroundTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.amber, Colors.white],
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // TimerInitial
              if (state is TimerInitial) ...[
                FloatingActionButton(
                  heroTag: "TimerInitialTimerStarted",
                  backgroundColor: Colors.amber,
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(duration: state.duration)),
                ),
              ],

              // TimerRunInProgress
              if (state is TimerRunInProgress) ...[
                FloatingActionButton(
                  heroTag: "TimerRunInProgressTimerPaused",
                  backgroundColor: Colors.yellow,
                  child: const Icon(Icons.pause),
                  onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                ),
                FloatingActionButton(
                  heroTag: "TimerRunInProgressTimerReset",
                  backgroundColor: Colors.yellowAccent,
                  child: const Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],

              // TimerRunPause
              if (state is TimerRunPause) ...[
                FloatingActionButton(
                  heroTag: "TimerRunPauseTimerResumed",
                  backgroundColor: Colors.amber,
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResumed()),
                ),
                FloatingActionButton(
                  heroTag: "TimerRunPauseTimerReset",
                  backgroundColor: Colors.yellowAccent,
                  child: const Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],

              // TimerRunComplete
              if (state is TimerRunComplete) ...[
                FloatingActionButton(
                  heroTag: "TimerRunCompleteTimerReset",
                  backgroundColor: Colors.amberAccent,
                  child: const Icon(Icons.replay),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ]
            ],
          );
        });
  }
}
