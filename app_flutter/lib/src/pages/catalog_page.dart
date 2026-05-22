import 'package:app_flutter/src/widgets/double_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CatalogPage extends StatefulWidget {

  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  final String name = 'teste';
  bool isEditing = true;
  late String orcamentoValue;

  void editOrcamento(String text) {
    print('Fui pressionado');
      setState(() {
        isEditing = !isEditing;
        orcamentoValue = text;
        
      });
    }

  @override
  Widget build(BuildContext context) {

    orcamentoValue = ModalRoute.of(context)!.settings.arguments as String;

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
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8
                ),
                child: Stack(
                  children: [ 
                    TextField(
                      controller: TextEditingController(text: orcamentoValue),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.monetization_on_rounded),
                        suffix: SizedBox(
                          width: 33.5,
                          height: 33.5,
                    
                        ),
                        label: Text('Orçamento'),
                        enabled: isEditing,
                        border: OutlineInputBorder()
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () => editOrcamento(orcamentoValue),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                              elevation: 5,
                              padding: EdgeInsets.zero,
                              fixedSize: const Size(33.5, 33.5),
                            ),
                            child: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                  ]
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