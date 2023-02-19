import 'package:flutter/material.dart';
import 'package:BarkMeow/Onboarding_screens/app_styles.dart';
import 'package:BarkMeow/Onboarding_screens/size_configs.dart';

// Extracting MyTextButton from default widget flow.
class MyTextButton extends StatelessWidget {
  MyTextButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,
  });
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        height: SizeConfig.blockSizeH! * 15.5,
        width: SizeConfig.blockSizeH! * 100.0,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
          ),
          child: Text(
            buttonName,
            style: kBodyText1,
          ),
        ),
      ),
    );
  }
}
