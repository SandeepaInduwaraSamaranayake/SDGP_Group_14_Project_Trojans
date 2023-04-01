import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';

class CustomizedButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  const CustomizedButton(
      {super.key,
      this.buttonText,
      this.buttonColor,
      this.onPressed,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    //get screen size configuration

    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02), //10.0
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: screenHeight * 0.06, // 50
          width: screenWidth,
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            buttonText!,
            style: TextStyle(
              color: textColor,
              fontSize: screenWidth * 0.03, //15
            ),
          )),
        ),
      ),
    );
  }
}
