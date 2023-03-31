import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  final double screenWidth;
  const HeadTitle({
    super.key,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05), //10
      child: Text("Hello! Register to get \nStart.",
          style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.07, //30
              fontWeight: FontWeight.bold,
              fontFamily: "Nexa")),
    );
  }
}
