import 'package:app_flutter/src/pages/catalog_page.dart';
import 'package:flutter/material.dart';

class AppFlutter extends StatelessWidget {
  const AppFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Flutter',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const CatalogPage()
      },
    );
  }
}