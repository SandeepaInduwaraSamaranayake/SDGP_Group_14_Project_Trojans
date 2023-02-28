import 'package:flutter/material.dart';
import './size_configs.dart';

// defining primary colors use for onboarding screens.
Color kPrimaryColor = const Color(0xffFC9D45);
Color kSecondaryColor = const Color(0xff573353);

// defining text styles for onboarding screens.
final kTitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: kSecondaryColor,
);

final kBodyText1 = TextStyle(
  fontFamily: 'Poppins',
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5,
  //fontWeight: FontWeight.bold,
);
