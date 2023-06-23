import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/courses/presentation/bloc/course_bloc.dart';
import 'package:project/features/courses/presentation/bloc/course_event.dart';
import 'package:project/features/courses/presentation/bloc/course_state.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CourseBloc>().add(const OnCourseLoaded());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await Future(() => context
            .read<CourseBloc>()
            .add(const OnCourseLoaded(forceRefresh: true))),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                centerTitle: true,
                title: const Text(
                  'Course List',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
            BlocBuilder<CourseBloc, CourseState>(buildWhen: (previous, next) {
              if (previous is CourseHasData == false) {
                return true;
              }
              return false;
            }, builder: (context, state) {
              if (state is CourseHasData) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    ...state.result
                        .asMap()
                        .entries
                        .map(
                          (e) => ListTile(
                            leading: const Icon(Icons.book_sharp),
                            trailing: const Icon(Icons.navigate_next_sharp),
                            subtitle: e.value.summary is String &&
                                    e.value.summary!.isNotEmpty
                                ? Text(e.value.summary!)
                                : null,
                            title: e.value.name is String &&
                                    e.value.name!.isNotEmpty
                                ? Text(e.value.name!)
                                : null,
                            tileColor:
                                e.key.isOdd ? Colors.white10 : Colors.white70,
                          ),
                        )
                        .toList()
                  ]),
                );
              }
              return SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 400),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
