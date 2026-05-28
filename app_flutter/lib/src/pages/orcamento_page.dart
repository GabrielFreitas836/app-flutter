import 'package:app_flutter/src/widgets/my_elevated_button.dart';
import 'package:app_flutter/src/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';

class OrcamentoPage extends StatefulWidget {
  const OrcamentoPage({super.key});

  @override
  State<OrcamentoPage> createState() => _OrcamentoPageState();
}

class _OrcamentoPageState extends State<OrcamentoPage> {

  final TextEditingController orcamentoController = TextEditingController();

  void switchToCatalogPage() {

    final userName = ModalRoute.of(context)?.settings.arguments as String?;

    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/catalog', 
      (route) => false,
      arguments: {
        'orcamento': orcamentoController.text.isNotEmpty ? orcamentoController.text : 0.toStringAsFixed(2),
        'userName': (userName != null && userName.isNotEmpty) ? userName : 'Usuário'
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(232, 248, 202, 202),
        ),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Text(
                  'ORÇAMENTO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
              MyTextFormFieldWidget(
                controller: orcamentoController,
                horizontalPadding: 16, 
                verticalPadding: 8,
                icon: Icons.monetization_on_rounded, 
                inputData: 'Orçamento',
                hintText: 'Defina o valor do orçamento',
                isNumberType: true,
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                onPressed: switchToCatalogPage,
                buttonText: 'Salvar'
              )
            ],
          )
        ),
      ),
    );
  }
}