import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BannerExample extends StatelessWidget {

  final Function? onBannerTap;

  final String? title;

  const BannerExample({super.key, this.onBannerTap, this.title = 'Banner Here'});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() => onBannerTap is Function ? onBannerTap: context.go('/home/banner'),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child:  Center(child: Text(
          title is String ? title.toString():  '' , style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
