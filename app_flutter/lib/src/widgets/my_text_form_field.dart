import 'package:flutter/material.dart';

class MyTextFormFieldWidget extends StatelessWidget {

  final double horizontalPadding;
  final double verticalPadding;
  final String inputData;
  final String? hintText;
  final bool isObscure;

  const MyTextFormFieldWidget({
    super.key,  
    required this.horizontalPadding, 
    required this.verticalPadding,
    required this.inputData,
    this.hintText,
    this.isObscure = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding
        ),
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          label: Text(inputData),
          hintText: hintText,
          filled: true,
          fillColor: const Color.fromARGB(167, 255, 255, 255),
          border: OutlineInputBorder()
        ),
      ),
    );
  }
}