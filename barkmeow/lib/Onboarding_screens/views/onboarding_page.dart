import 'package:barkmeow/Onboarding_screens/model/onboard_data.dart';
import 'package:barkmeow/Onboarding_screens/size_configs.dart';
import 'package:barkmeow/main.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/Onboarding_screens/app_styles.dart';
import 'package:barkmeow/Sign_Up_Page/views/pages.dart';
import 'package:barkmeow/Onboarding_screens/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  // create dot indicator
  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      // margin to make dots seperated from each other.
      margin: const EdgeInsets.only(right: 10),
      duration: const Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

// This method will set the variable 'seenOnboard' to true when running onboard page
// for the first time.
  Future setSeenOnboard() async {
    // getting an instance of SharedPreferences class.
    SharedPreferences pref = await SharedPreferences.getInstance();
    // setting seenOnboard variable to true after showing the onboard screens.
    seenOnboard = await pref.setBool('seenOnboard', true);
  }

// This will call the setSeenOnboard() method when running onboard pages for the
// first time.
  @override
  void initState() {
    super.initState();
    setSeenOnboard();
  }

  @override
  Widget build(BuildContext context) {
    // initialize size configuration.
    SizeConfig().init(context);
    //double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    // create scaffold.
    return Scaffold(
      backgroundColor: Colors.white,
      // create body of the scaffoled with a safe area.
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // divide screen into 10 horizontal parts.
              // and give 9 out of 10 screen size to this expand widget.
              flex: 9,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingContents.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    // The empty space above title at the very top of the screen
                    SizedBox(
                      height: sizeV * 5,
                    ),
                    // The title of the page
                    Text(
                      onboardingContents[index].title,
                      style: kTitle,
                      textAlign: TextAlign.center,
                    ),
                    // The empty space between title and the image container
                    SizedBox(
                      height: sizeV * 5,
                    ),
                    // Image container which hold the image
                    SizedBox(
                      height: sizeV * 50,
                      // Set image to the container
                      child: Image.asset(
                        // Set image asset
                        onboardingContents[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // The empty space between image and the RichText widget
                    SizedBox(
                      height: sizeV * 5,
                    ),
                    // The description of the onboard screen.
                    RichText(
                      textAlign: TextAlign.center,
                      text: onboardingContents[index].subtitle,
                    ),
                    // The empty space between description and footer buttons
                    // and dot indicators.
                    SizedBox(
                      height: sizeV * 5,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              // give 1 out of 10 screen size to this expand widget.
              flex: 1,
              child: Column(
                children: [
                  // here if current page is the last page, show 'Get Started button'
                  // if it not the last page, show 'Skip', 'Next' and dot indicators.
                  currentPage == onboardingContents.length - 1
                      // 'Get Started' button.
                      ? MyTextButton(
                          buttonName: 'Get Started',
                          // 'Get Started' button action.
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          bgColor: kPrimaryColor,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 'Skip' button.
                            OnBoardNavBtn(
                              name: 'Skip',
                              // 'Skip' button action.
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                            ),
                            // Row for dot indicators.
                            Row(
                              children: List.generate(
                                onboardingContents.length,
                                (index) => dotIndicator(index),
                              ),
                            ),
                            // 'Next' button.
                            OnBoardNavBtn(
                                name: 'Next ',
                                // 'Next' button action.
                                onPressed: () {
                                  _pageController.nextPage(
                                      // simple easeInOut effect when changing
                                      // one boarding screen to another.
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                })
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
