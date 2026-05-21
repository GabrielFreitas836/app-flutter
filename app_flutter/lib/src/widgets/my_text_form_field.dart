import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFieldWidget extends StatelessWidget {

  final TextEditingController controller;
  final double horizontalPadding;
  final double verticalPadding;
  final IconData? icon;
  final String inputData;
  final String? hintText;
  final bool isObscure;
  final bool isNumberType;

  const MyTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.horizontalPadding,
    required this.verticalPadding,
    this.icon,
    required this.inputData,
    this.hintText,
    this.isObscure = false,
    this.isNumberType = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding
        ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: isNumberType ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
        inputFormatters: isNumberType ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))] : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
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