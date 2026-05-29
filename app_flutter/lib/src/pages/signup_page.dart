import 'package:app_flutter/src/providers/user_provider.dart';
import 'package:app_flutter/src/widgets/my_elevated_button.dart';
import 'package:app_flutter/src/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void switchToLoginPage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
      arguments: nameController.text,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(232, 248, 202, 202)),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Text(
                  'CADASTRO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                ),
              ),
              MyTextFormFieldWidget(
                controller: nameController,
                horizontalPadding: 16,
                verticalPadding: 8,
                icon: Icons.man_2_rounded,
                inputData: 'Nome de Usuário',
              ),
              MyTextFormFieldWidget(
                controller: emailController,
                horizontalPadding: 16,
                verticalPadding: 8,
                icon: Icons.email_rounded,
                inputData: 'E-mail',
              ),
              MyTextFormFieldWidget(
                controller: passwordController,
                horizontalPadding: 16,
                verticalPadding: 8,
                icon: Icons.lock,
                inputData: 'Senha',
                isObscure: true,
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                onPressed: () async {
                  final messager = ScaffoldMessenger.of(context);

                  try {
                    final result = await context.read<UserProvider>().register(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                    );

                    if (!mounted) return;

                    if (result['success'] == true) {
                      messager.showSnackBar(
                        SnackBar(
                          content: Text(
                            result['message'] as String? ??
                                'Cadastro realizado com sucesso!',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      messager.showSnackBar(
                        SnackBar(
                          content: Text(
                            result['message'] as String? ??
                                'Falha ao realizar cadastro!',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    switchToLoginPage();
                  } catch (e) {
                    if (!mounted) return;

                    messager.showSnackBar(
                      SnackBar(
                        content: Text('Erro: ${e.toString().split(":").last}.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                buttonText: 'Cadastrar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
