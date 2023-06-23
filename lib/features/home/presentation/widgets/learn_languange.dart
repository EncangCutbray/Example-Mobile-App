import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearnLanguange extends StatelessWidget {
  const LearnLanguange({super.key, required this.flagUrl, required this.title});

  final String flagUrl;
  final String title;

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
      child: Column(
        children: [
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
                ...List.generate(
                  6,
                  (index) => ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 69,
                      minHeight: 82,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => context.go('/home/flag'),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Image.network(flagUrl, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Expanded(child: Text("Start")),
                      ],
                    ),
                  ),
                ).toList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
