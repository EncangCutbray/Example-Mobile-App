import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/home_details/counter/presentation/bloc/counter_bloc.dart';

class CounterPage extends StatelessWidget {
  final String title;

  const CounterPage({super.key, this.title = 'Counter Page'});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            final totalCounter = state.totalCounter.counterValue;
            return Text(
              totalCounter.toString(),
              style: textTheme.displayMedium,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.amber,
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterBloc>().add(const CounterIncrementPressed(1));
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            backgroundColor: Colors.amber,
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<CounterBloc>().add(const CounterDecrementPressed(1));
            },
          ),
        ],
      ),
    );
  }
}
