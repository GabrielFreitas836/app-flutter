import 'package:flutter/material.dart';

class DoubleCardWidget extends StatelessWidget {

  final String cardText;
  final double padding;
  final int cardsPerRow = 2;
  final int numberOfCards;

  const DoubleCardWidget({
    super.key, 
    required this.cardText, 
    required this.padding,
    this.numberOfCards = 1
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: padding,
      runSpacing: padding,
      children: List.generate(numberOfCards, (index) {
        return SizedBox(
          width: 150,
          height: 150,
          child: Card(
            color: const Color.fromARGB(255, 243, 243, 243),
            elevation: 5,
            child: Center(
              child: Text(
                cardText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }),
    );
  }
}
