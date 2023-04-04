import 'package:barkmeow/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';

class GallaryActionButton extends StatelessWidget {
  const GallaryActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //get screen size configuration
    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;
    return CircleAvatar(
      radius: 50.0,
      backgroundColor: circularButtonBackColor,
      child: const Icon(
        Icons.photo_library,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
