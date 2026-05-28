import 'package:app_flutter/src/models/product_model_a.dart';
import 'package:app_flutter/src/providers/product_provider.dart';
import 'package:app_flutter/src/widgets/double_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {

  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  bool isEditing = false;
  bool wasSetted = false;
  late String orcamentoValue;
  late String newOrcamento;
  TextEditingController orcamentoController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController unitValueController = TextEditingController();
  TextEditingController unitTypeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  void canEditOrcamento() {
      setState(() {
        isEditing = !isEditing;
      });
    }

  void setNewOrcamento(String newText) {
    setState(() {
      newOrcamento = newText;
      orcamentoController.text = newOrcamento;
      wasSetted = true;
    });
  }

  void newCard(ProductProvider productProvider) {
    setState(() {
      showDialog (
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Adicionar Novo Produto',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      label: const Text('Descrição'),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: unitValueController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                    decoration: InputDecoration(
                      label: const Text('Valor Unitário'),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: unitTypeController,
                    decoration: InputDecoration(
                      label: const Text('Tipo de Unidade'),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      label: const Text('Categoria'),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                   try {
                    if (!mounted) return;

                    final result = await context.read<ProductProvider>().addProduct(
                      ProductModelA(
                        description: descriptionController.text,
                        unitValue: double.parse(unitValueController.text),
                        unitType: unitTypeController.text,
                        category: categoryController.text
                      )
                    );

                    if (result['success'] == true) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['message'] ?? 'Produto adicionado com sucesso!'),
                          duration: const Duration(seconds: 3),
                        )
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro: ${result['message'] ?? 'Falha ao adicionar o produto!'}'),
                          duration: const Duration(seconds: 3),
                        )
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro: ${e.toString().split(":").last}'),
                        duration: const Duration(seconds: 3),
                      )
                    );
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        }
      );
    });
  }

  void removeCard() {
    setState(() {
        showDialog (
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Excluir Produto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              content: const Text(
                'Tem certeza que deseja excluir este produto?',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para excluir o produto
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Produto excluído com sucesso!'),
                        duration: Duration(seconds: 3),
                      )
                    );
                  },
                  child: const Text('Excluir'),
                ),
              ],
            );
          }
        );
    });
  }
  
  @override
  Widget build(BuildContext context) {

    final productProvider = context.watch<ProductProvider>();
    
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    
    if (wasSetted){
      orcamentoController.text = newOrcamento;
    } 
    else {
      orcamentoController.text = args['orcamento']!;
      newOrcamento = args['orcamento']!;
    }

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
                'Olá, ${args['userName']}! Seja bem-vindo!',
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
                      controller: orcamentoController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      onChanged: setNewOrcamento,
                      onSubmitted: setNewOrcamento,
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
                            onPressed: canEditOrcamento,
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
                padding: 20,
                onTap: removeCard,
              ),
              const SizedBox(height: 7),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 280,
                    height: 150,
                    child: GestureDetector(
                      onTap: () => newCard(productProvider),
                      child: Card(
                        color: const Color.fromARGB(255, 243, 243, 243),
                        elevation: 5,
                        child: Center(
                          child: Icon(Icons.add)
                        ),
                      ),
                    ),
                  ),
                ] 
              ),
            ]
          ),
        )
      )
    );
  }
}