import 'package:flutter/material.dart';
import 'package:barkmeow/app_styles.dart';

// Extracting Cardview from profile page
class CardViewSingleLabel extends StatelessWidget {
  const CardViewSingleLabel({super.key, required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cardName, style: profileCards),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
