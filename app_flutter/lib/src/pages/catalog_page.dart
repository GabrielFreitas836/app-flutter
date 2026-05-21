import 'package:app_flutter/src/widgets/double_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CatalogPage extends StatelessWidget {

  final String name = 'teste';

  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {

    final String orcamentoValue = ModalRoute.of(context)!.settings.arguments as String;

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
              Text(
                'Olá, $name! Seja bem-vindo!',
                style: TextStyle(
                  color: const Color.fromARGB(232, 128, 128, 128),
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8
                ),
                child: TextField(
                  controller: TextEditingController(text: orcamentoValue),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d\.?\d{0,2}$'))],
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
                padding: 16,
                numberOfCards: 10
              ),
            ]
          ),
        )
      )
    );
  }
}