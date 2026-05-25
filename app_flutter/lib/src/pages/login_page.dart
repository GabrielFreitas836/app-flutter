import 'package:app_flutter/src/providers/user_provider.dart';
import 'package:app_flutter/src/widgets/my_elevated_button.dart';
import 'package:app_flutter/src/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool canAuthenticate = false;
  
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<UserProvider>().login(emailController.text, passwordController.text);
    });
  }
  void switchToOrcamentoPage(String token) {
    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/orcamento', 
      (route) => false,
      arguments: token
    );
  }

  void switchToSignupPage() {
    Navigator.of(context).pushNamed('/signup');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = context.watch<UserProvider>();

    if (userProvider.data['success'] == true) {
      canAuthenticate = true;
    }

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
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
              MyTextFormFieldWidget(
                controller: emailController,
                horizontalPadding: 16, 
                verticalPadding: 8,
                icon: Icons.email_rounded,
                inputData: 'E-mail'
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
              GestureDetector(
                onTap: switchToSignupPage,
                child: Text(
                  'Não possui conta? Cadastre-se agora!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 15.5),
              MyElevatedButton(
                onPressed: () {
                  if (canAuthenticate) {
                    switchToOrcamentoPage(userProvider.data['token']);
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(userProvider.data['message'] as String? ?? 'Falha ao realizar login'),
                      ),
                    );
                  }
                }, 
                buttonText: 'Logar'
              )
            ],
          )
        ),
      ),
    );
  }
}