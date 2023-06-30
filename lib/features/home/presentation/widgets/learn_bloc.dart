import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearnBloc extends StatelessWidget {
  LearnBloc({super.key});

  final String title = 'List Learn Bloc';

  final List<Map<String, String>> listOfLearning = [
    {'route': '/home/counter', 'title': 'Counter'},
    {'route': '/home/timer', 'title': 'Timer'},
    {'route': '/home/weather', 'title': 'Weather'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          width: double.infinity,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              ...listOfLearning
                  .map((e) => ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 69,
                          minHeight: 82,
                        ),
                        child: Column(children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => context.go(e['route'].toString()),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade100,
                                    width: 2.5,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(child: Text(e['title'].toString())),
                        ]),
                      ))
                  .toList(),
            ],
          ),
        ),
      ]),
    );
  }
}
