import 'package:app_flutter/src/pages/catalog_page.dart';
import 'package:app_flutter/src/pages/login_page.dart';
import 'package:app_flutter/src/pages/orcamento_page.dart';
import 'package:app_flutter/src/pages/signup_page.dart';
import 'package:app_flutter/src/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppFlutter extends StatelessWidget {
  const AppFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'App Flutter',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const LoginPage(),
          '/signup': (_) => const SignupPage(),
          '/orcamento': (_) => const OrcamentoPage(),
          '/catalog': (_) => const CatalogPage()
        },
      ),
    );
  }
}