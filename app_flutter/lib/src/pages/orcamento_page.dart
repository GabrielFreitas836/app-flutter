import 'package:app_flutter/src/providers/user_provider.dart';
import 'package:app_flutter/src/widgets/my_elevated_button.dart';
import 'package:app_flutter/src/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrcamentoPage extends StatefulWidget {
  const OrcamentoPage({super.key});

  @override
  State<OrcamentoPage> createState() => _OrcamentoPageState();
}

class _OrcamentoPageState extends State<OrcamentoPage> {
  final TextEditingController orcamentoController = TextEditingController();

  Future<void> switchToCatalogPage() async {
    final userName = ModalRoute.of(context)?.settings.arguments as String?;
    final messenger = ScaffoldMessenger.of(context);
    final orcamento = orcamentoController.text.isNotEmpty
        ? orcamentoController.text
        : 0.toStringAsFixed(2);

    try {
      final result = await context.read<UserProvider>().updateOrcamentoByUserId(
        orcamento,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/catalog',
          (route) => false,
          arguments: {
            'userName': (userName != null && userName.isNotEmpty)
                ? userName
                : 'Usuário',
          },
        );
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              result['message'] ?? 'Falha ao atualizar o orçamento!',
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString().split(":").last}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    orcamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(232, 248, 202, 202),
        ),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 45),
                child: Text(
                  'ORÇAMENTO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
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
                buttonText: 'Salvar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
