import 'package:flutter/material.dart';

class AppFlutter extends StatelessWidget {
  const AppFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Flutter',
      debugShowCheckedModeBanner: false
    );
  }
}