import 'package:flutter/material.dart';

class DoubleCardWidget extends StatelessWidget {

  final List<String> cardTexts;
  final double padding;
  final int cardsPerRow = 2;
  final int numberOfCards;

  const DoubleCardWidget({
    super.key, 
    required this.cardTexts, 
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
          width: 180,
          height: 210,
          child: Card(
            color: const Color.fromARGB(255, 243, 243, 243),
            elevation: 5,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: padding,
              children: [
                Text(
                  cardTexts[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
                Text(
                  cardTexts[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10
                  ),
                ),
                Text(
                  cardTexts[2],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10
                  ),
                ),
                Text(
                  cardTexts[3],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13
                  ),
                ),
                Badge(
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5
                  ),
                  label: Text(
                    'Badge',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.25
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
