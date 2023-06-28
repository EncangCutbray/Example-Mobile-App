import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  final String title;

  const WeatherPage({super.key, this.title = 'Weather Page'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
    );
  }
}
