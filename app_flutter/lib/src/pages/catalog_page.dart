import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Catalog Page',
          style: TextStyle(
            color: Color.fromARGB(255, 229, 226, 226),
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(232, 248, 202, 202)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text('Orçamento'),
                border: OutlineInputBorder()
              ),
            )
          ],
        ),
      ),
    );
  }
}