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
    title: 'Welcome To BarkMeow!',
    subtitle: subtitle1,
    image: 'assets/images/onboard_images/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'Join A Community!',
    subtitle: subtitle2,
    image: 'assets/images/onboard_images/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Find The Breed!',
    subtitle: subtitle3,
    image: 'assets/images/onboard_images/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Post Your Pet!',
    subtitle: subtitle4,
    image: 'assets/images/onboard_images/onboarding_image_4.png',
  ),
  OnBoarding(
    title: 'Verify your profile as A Vet!',
    subtitle: subtitle5,
    image: 'assets/images/onboard_images/onboarding_image_5.png',
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
    const TextSpan(text: ' PARENT FOR YOUR'),
    TextSpan(
      text: ' PET',
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
    const TextSpan(text: 'JOIN'),
    TextSpan(
      text: ' GROUPS AND CHAT',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' WITH'),
    const TextSpan(text: ' PET PARENT'),
    TextSpan(
      text: ' COMMUNITY',
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
    const TextSpan(text: 'DISCOVER YOUR'),
    TextSpan(
      text: ' FURRY FRIEND\'S ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' BREED'),
    const TextSpan(text: ' WITH JUST'),
    TextSpan(
      text: ' A SNAP',
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
    const TextSpan(text: 'SHARE THE'),
    TextSpan(
      text: ' LOVE FOR YOUR',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' FURRY FRIENDS'),
    const TextSpan(text: ' CAPTURE AND POST'),
    TextSpan(
      text: ' WITH BARKMEOW',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
);

// This is the fifth onboard screen subtitle TextSpan object.
TextSpan subtitle5 = TextSpan(
  style: kBodyText1,
  children: [
    const TextSpan(text: 'VERIFY YOUR'),
    TextSpan(
      text: ' PROFILE AS A VET',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(text: ' BY SUBMITTING'),
    const TextSpan(text: ' YOUR VET ID'),
    TextSpan(
      text: ' AND DOCUMENTS',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
);
