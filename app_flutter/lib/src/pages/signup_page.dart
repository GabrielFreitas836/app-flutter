import 'package:app_flutter/src/widgets/my_elevated_button.dart';
import 'package:app_flutter/src/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(232, 248, 202, 202),
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Text(
                    'CADASTRO',
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
                  inputData: 'Nome de Usuário'
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
                MyElevatedButton(
                  onPressed: (){}, 
                  buttonText: 'Cadastrar'
                )
              ],
            )
            ),
        ),
      ),
    );
  }
}