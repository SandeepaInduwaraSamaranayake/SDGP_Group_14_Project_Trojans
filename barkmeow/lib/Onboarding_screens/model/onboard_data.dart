import 'package:flutter/material.dart';
import 'package:barkmeow/Onboarding_screens/app_styles.dart';

class OnBoarding {
  final String title;
  final TextSpan subtitle;
  final String image;

  OnBoarding({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Welcome to\n Monumental habits',
    subtitle: subtitle1,
    image: 'assets/images/onboard_images/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'Create new habits easily',
    subtitle: subtitle2,
    image: 'assets/images/onboard_images/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Keep track of your progress',
    subtitle: subtitle3,
    image: 'assets/images/onboard_images/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Join a supportive community',
    subtitle: subtitle4,
    image: 'assets/images/onboard_images/onboarding_image_4.png',
  ),
];

// This is the first onboard screen subtitle TextSpan object.
TextSpan subtitle1 = TextSpan(
  style: kBodyText1,
  children: [
    const TextSpan(text: 'WE CAN'),
    TextSpan(
      text: ' HELP YOU',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' TO BE A BETTER'),
    const TextSpan(text: ' VERSION OF'),
    TextSpan(
      text: ' YOURSELF',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
);

// This is the second onboard screen subtitle TextSpan object.
TextSpan subtitle2 = TextSpan(
  style: kBodyText1,
  children: [
    const TextSpan(text: 'WE CAN'),
    TextSpan(
      text: ' HELP YOU',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' TO BE A BETTER'),
    const TextSpan(text: ' VERSION OF'),
    TextSpan(
      text: ' YOURSELF',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
);

// This is the third onboard screen subtitle TextSpan object.
TextSpan subtitle3 = TextSpan(
  style: kBodyText1,
  children: [
    const TextSpan(text: 'WE CAN'),
    TextSpan(
      text: ' HELP YOU',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' TO BE A BETTER'),
    const TextSpan(text: ' VERSION OF'),
    TextSpan(
      text: ' YOURSELF',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
);

// This is the fourth onboard screen subtitle TextSpan object.
TextSpan subtitle4 = TextSpan(
  style: kBodyText1,
  children: [
    const TextSpan(text: 'WE CAN'),
    TextSpan(
      text: ' HELP YOU',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' TO BE A BETTER'),
    const TextSpan(text: ' VERSION OF'),
    TextSpan(
      text: ' YOURSELF',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
);
