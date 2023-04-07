import 'package:flutter/material.dart';
import 'size_configs.dart';

// Here you can define all the colors and text styles which are
// using by this application.

// defining primary & secondary colors use for onboarding screens.
Color kPrimaryColor = const Color(0xffFC9D45);
Color kSecondaryColor = const Color(0xff573353);

// defining navigation bar selected and unselected colors.
Color navigationBarSelectedColor = const Color(0xff000000);
Color navigationBarNotSelectedColor = const Color(0xFFFFA500);

// defining profile page colors.
Color cyanInkwellColor = const Color(0xFF00BCD4);
Color greyColor = const Color(0x60000000);

// sign in/ sign up button colors.
Color signInSignUpBtnColor = const Color(0xFFFFA500);
// sign in/ sign up orange small text colors.
Color signInSignUptxtColor = const Color(0xFFFFA500);

// sign in / sign up grey small text colors.
Color signInSignUpGreytxtColor = const Color(0XFF6A707C);

// forgot password text color
Color forgotPasswordGreytxtColor = const Color(0XFF6A707C);

// sign in / sign up btn txt colors.
Color signInSignUpBtnTxtColor = Colors.black;

// breed identifier circular buttons background color.
Color circularButtonBackColor = const Color(0xFFFFA500);

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

// defining text styles for profile page

final profileBlueTitle = TextStyle(
  fontFamily: 'Poppins',
  color: cyanInkwellColor,
  fontSize: SizeConfig.blockSizeH! * 4,
);

final profileBlueBody = TextStyle(
  fontFamily: 'Poppins',
  color: cyanInkwellColor,
  fontSize: SizeConfig.blockSizeH! * 3.5,
);

final profileGreyInstructions = TextStyle(
  fontFamily: 'Poppins',
  color: greyColor,
  fontSize: SizeConfig.blockSizeH! * 2.8,
);

final profileCards = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 3.7,
);

final profileCardsValues = TextStyle(
  fontFamily: 'Poppins',
  color: greyColor,
  fontSize: SizeConfig.blockSizeH! * 3.4,
);
