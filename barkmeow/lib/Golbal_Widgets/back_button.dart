import 'package:flutter/material.dart';

class CustomizedBackButton extends StatelessWidget {
  final double screenWidth;
  const CustomizedBackButton({
    super.key,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Container(
        height: screenWidth * 0.1, //50
        width: screenWidth * 0.1, //50
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Center(
          child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              iconSize: screenWidth * 0.05,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}
