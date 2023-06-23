import 'package:flutter/material.dart';
import 'package:project/features/home/presentation/widgets/banner_example.dart';
import 'package:project/features/home/presentation/widgets/learn_languange.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, this.title = 'Home'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            BannerExample(),
            Padding(padding: EdgeInsets.only(top: 10)),
            LearnLanguange(
              flagUrl:
                  'https://ducc.pythonanywhere.com/static/images/flags/ru-f.png',
              title: 'Booking a new rocket? Just clicked',
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            BannerExample(),
            Padding(padding: EdgeInsets.only(top: 10)),
            LearnLanguange(
              flagUrl:
                  'https://ducc.pythonanywhere.com/static/images/flags/kp-f.png',
              title: 'Start war journey, Only one clicked',
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            BannerExample(),
            Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ),
      ),
    );
  }
}
