import 'package:flutter/material.dart';

class BottomSeperater extends StatelessWidget {
  final String caption;
  const BottomSeperater({
    super.key,
    required this.screenWidth,
    required this.caption,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05), //20
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1,
            width: screenWidth * 0.34,
            color: Colors.grey,
          ),
          Text(
            caption,
            style: const TextStyle(
              color: Color(0XFF6A707C),
            ),
          ),
          Container(
            height: 1,
            width: screenWidth * 0.34,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
