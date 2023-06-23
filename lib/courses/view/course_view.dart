import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/widgets/navigation_bar_app.dart';
import 'package:project/courses/cubit/course_cubit.dart';
import 'package:project/courses/models/course_model.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: BlocBuilder<CourseCubit, CourseModel>(
                builder: (context, state) {
                  return Text('Course List 54 ${state.counter}');
                },
              ),
            ),
          ),
          BlocBuilder<CourseCubit, CourseModel>(builder: (context, state) {
            return SliverList(
              delegate: SliverChildListDelegate(
                state.toArrayResult()['data'] == null
                    ? [
                        ...[
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Center(
                                  child: CircularProgressIndicator()))
                        ]
                      ]
                    : [
                        ...state
                            .toArrayResult()['data']
                            .asMap()
                            .entries
                            .map(
                              (e) => ListTile(
                                leading: const Icon(Icons.book_sharp),
                                tileColor: e.key.isOdd
                                    ? Colors.white10
                                    : Colors.white70,
                                onTap: () => context.go('/details'),
                                title: e.value.containsKey('name') &&
                                        e.value['name'].isNotEmpty
                                    ? Text(e.value['name'])
                                    : null,
                                subtitle: e.value.containsKey('summary') &&
                                        e.value['summary'].isNotEmpty
                                    ? Text(e.value['summary'])
                                    : null,
                                trailing: const Icon(Icons.navigate_next_sharp),
                              ),
                            )
                            .toList()
                      ],
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar:  const NavigationBarApp(),
     
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: UniqueKey(),
            key: const Key('coursePage_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<CourseCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: UniqueKey(),
            key: const Key('coursePage_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CourseCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
