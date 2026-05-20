import 'package:app_flutter/src/widgets/my_elevated_button.dart';
import 'package:app_flutter/src/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void switchToCatalogPage() {
    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/catalog', 
      (route) => false
    );
  }

  void switchToSignupPage() {
    Navigator.of(context).pushNamed('/signup');
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
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
              MyTextFormFieldWidget(
                horizontalPadding: 16, 
                verticalPadding: 8, 
                inputData: 'E-mail'
              ),
              MyTextFormFieldWidget(
                horizontalPadding: 16, 
                verticalPadding: 8, 
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
                onPressed: switchToCatalogPage, 
                buttonText: 'Logar'
              )
            ],
          )
        ),
      ),
    );
  }
}