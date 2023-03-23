import 'package:barkmeow/app_styles.dart';
import 'package:flutter/material.dart';

class CardViewDoubleLabel extends StatelessWidget {
  const CardViewDoubleLabel({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: profileCards,
            ),
            Text(
              value,
              style: profileCardsValues,
            ),
            //add Icon Button
            Transform.scale(
              scale: 0.7,
              child: IconButton(
                onPressed: () {
                  //action coe when button is pressed
                },
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                color: greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
