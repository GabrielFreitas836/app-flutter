import 'package:flutter/material.dart';

class DoubleCardWidget extends StatelessWidget {

  final String cardText;
  final double padding;
  
  const DoubleCardWidget({
    super.key, 
    required this.cardText, 
    required this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Card(
              color: const Color.fromARGB(255, 243, 243, 243),
              elevation: 5,
              child: Text(
                cardText,
                textAlign: TextAlign.center
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Card(
              color: const Color.fromARGB(255, 243, 243, 243),
              elevation: 5,
              child: Text(
                cardText,
                textAlign: TextAlign.center
              ),
            ),
          ),
        ),
      ],
    );
  }
}