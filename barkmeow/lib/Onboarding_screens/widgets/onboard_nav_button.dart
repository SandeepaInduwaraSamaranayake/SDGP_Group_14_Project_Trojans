import 'package:flutter/material.dart';
import 'package:barkmeow/Onboarding_screens/app_styles.dart';

// Extracting OnBoardNavBtn from default widget flow.
class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({
    super.key,
    required this.name,
    required this.onPressed,
  });

  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: kBodyText1,
        ),
      ),
    );
  }
}
