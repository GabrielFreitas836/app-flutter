import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {

  final Function() onPressed;
  final String buttonText;

  const MyElevatedButton({
    super.key,
    required this.onPressed, 
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: Text(buttonText)
    );
  }
}