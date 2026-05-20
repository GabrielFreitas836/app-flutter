import 'package:flutter/material.dart';

class MyTextFormFieldWidget extends StatelessWidget {

  final double horizontalPadding;
  final double verticalPadding;
  final String inputData;
  final bool isObscure;

  const MyTextFormFieldWidget({
    super.key,  
    required this.horizontalPadding, 
    required this.verticalPadding,
    required this.inputData,
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
          border: OutlineInputBorder()
        ),
      ),
    );
  }
}