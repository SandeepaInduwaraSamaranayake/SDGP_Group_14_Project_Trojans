import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';

class ActionText extends StatelessWidget {
  final String text;
  const ActionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    //get screen size configuration.
    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03), //20
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth * 0.04, // 18
        ),
      ),
    );
  }
}
