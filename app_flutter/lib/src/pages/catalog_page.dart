import 'package:app_flutter/src/widgets/double_card.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8
                ),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Orçamento'),
                    enabled: false,
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(height: 5),
              DoubleCardWidget(
                cardText: 'Teste',
                padding: 16
              ),
              DoubleCardWidget(
                cardText: 'Teste',
                padding: 16
              ),
              DoubleCardWidget(
                cardText: 'Teste',
                padding: 16
              ),
              DoubleCardWidget(
                cardText: 'Teste',
                padding: 16
              )
            ]
          ),
        )
      )
    );
  }
}