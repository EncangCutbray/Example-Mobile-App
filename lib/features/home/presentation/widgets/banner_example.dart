import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BannerExample extends StatelessWidget {
  const BannerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() => context.go('/home/banner'),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: const Center(child: Text('Banner Here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
