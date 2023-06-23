import 'package:flutter/material.dart';

class ExampleView extends StatelessWidget {
  final String title;

  const ExampleView({super.key, this.title = 'Title'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(title)),
    );
  }
}
