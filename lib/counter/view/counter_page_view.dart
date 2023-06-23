// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/counter/view/counter_view.dart';
import 'package:project/counter/cubit/counter_cubit.dart';

class CounterPageView extends StatelessWidget {
  const CounterPageView({super.key});

  @override
  Widget build(BuildContext context) {

    /// 1. Single BLOC
    /**
      return BlocProvider(
      create: (_) => CounterCubit(0),
      child: const CounterView(),
    );
     */

    /// 2. Multiple BLOC
    /**
     return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
          create: (BuildContext context) => CounterCubit(0),
        ),
      ],
      child: const CounterView(),
    );
     */


    /// 3. Move All BLOC To Root Application
    return const CounterView();
  }
}
