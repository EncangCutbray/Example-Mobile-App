import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  final String title;

  const CounterPage({super.key, this.title = 'Counter Page'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
    );
  }
}
