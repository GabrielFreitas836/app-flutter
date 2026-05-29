import 'package:app_flutter/src/models/product_model_b.dart';
import 'package:app_flutter/src/providers/product_provider.dart';
import 'package:app_flutter/src/providers/user_provider.dart';
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
  String newOrcamento = '0.00';
  final TextEditingController orcamentoController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController unitValueController = TextEditingController();
  final TextEditingController unitTypeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(loadOrcamento);
  }

  String formatOrcamento(dynamic value) {
    if (value == null) {
      return '0.00';
    }

    if (value is num) {
      return value.toStringAsFixed(2);
    }

    final parsedValue = double.tryParse(value.toString());
    return parsedValue != null
        ? parsedValue.toStringAsFixed(2)
        : value.toString();
  }

  Future<void> loadOrcamento() async {
    try {
      final result = await context.read<UserProvider>().getOrcamentoByUserId();
      final values = result['values'];
      final orcamento = values is Map<String, dynamic>
          ? values['orcamento']
          : null;

      if (!mounted || wasSetted) return;

      setState(() {
        newOrcamento = formatOrcamento(orcamento);
        orcamentoController.text = newOrcamento;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString().split(":").last}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void canEditOrcamento() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void setNewOrcamento(String newText) {
    setState(() {
      newOrcamento = newText;
      wasSetted = true;
    });
  }

  void newCard() {
    setState(() {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text(
              'Adicionar Novo Produto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: unitValueController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'),
                      ),
                    ],
                    decoration: InputDecoration(
                      label: const Text('Valor Unitário'),
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: categoryController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      label: const Text('Categoria'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final categoryId = int.parse(categoryController.text);

                    if (!mounted) return;

                    final result = await context
                        .read<ProductProvider>()
                        .addProduct(
                          ProductModelB(
                            description: descriptionController.text,
                            unitValue: double.parse(unitValueController.text),
                            unitType: unitTypeController.text,
                            categoryId: categoryId,
                          ),
                        );

                    if (!mounted || !dialogContext.mounted) return;

                    if (result['success'] == true) {
                      Navigator.of(dialogContext).pop();
                      descriptionController.clear();
                      unitValueController.clear();
                      unitTypeController.clear();
                      categoryController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result['message'] ??
                                'Produto adicionado com sucesso!',
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Erro: ${result['message'] ?? 'Falha ao adicionar o produto!'}',
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  } catch (e) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro: ${e.toString().split(":").last}'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        },
      );
    });
  }

  void removeCard(int productId) {
    setState(() {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text(
              'Excluir Produto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Tem certeza que deseja excluir este produto?',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await context
                        .read<ProductProvider>()
                        .deleteProduct(productId);

                    if (!mounted || !dialogContext.mounted) return;

                    if (result['success'] == true) {
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result['message'] ??
                                'Produto excluído com sucesso!',
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Erro: ${result['message'] ?? 'Falha ao excluir o produto!'}',
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  } catch (e) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro: ${e.toString().split(":").last}'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: const Text('Excluir'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    orcamentoController.dispose();
    descriptionController.dispose();
    unitValueController.dispose();
    unitTypeController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final userName = args is Map
        ? args['userName']?.toString() ?? 'Usuário'
        : 'Usuário';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Catalog Page',
          style: TextStyle(
            color: Color.fromARGB(255, 229, 226, 226),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(232, 248, 202, 202),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Olá, $userName! Seja bem-vindo!',
                style: TextStyle(
                  color: const Color.fromARGB(232, 128, 128, 128),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: orcamentoController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'),
                        ),
                      ],
                      onChanged: setNewOrcamento,
                      onSubmitted: setNewOrcamento,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.monetization_on_rounded),
                        suffix: SizedBox(width: 33.5, height: 33.5),
                        label: Text('Orçamento'),
                        enabled: isEditing,
                        border: OutlineInputBorder(),
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
                  ],
                ),
              ),
              const SizedBox(height: 5),
              DoubleCardWidget(
                padding: 20,
                onTap: removeCard,
                cardLabelBuilder: (product, index) {
                  final budget = double.tryParse(orcamentoController.text) ?? 0.0;
                  final isAvailable = product.unitValue <= budget;

                  return Text(
                    isAvailable ? 'Disponível' : 'Indisponível',
                    style: TextStyle(
                      color: isAvailable
                          ? const Color.fromARGB(255, 77, 236, 104)
                          : const Color.fromARGB(255, 236, 77, 77),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },

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
                      onTap: newCard,
                      child: Card(
                        color: const Color.fromARGB(255, 243, 243, 243),
                        elevation: 5,
                        child: Center(child: Icon(Icons.add)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
