import 'package:barkmeow/Contact_Us/views/contact_us_page.dart';
import 'package:barkmeow/Help_Center/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:barkmeow/Profile_Page/widgets/card_view_double_label.dart';
import 'package:barkmeow/Profile_Page/widgets/card_view_single_label.dart';
import 'package:barkmeow/Profile_Page/widgets/log_out_widget.dart';
import 'package:barkmeow/Profile_Edit_Page/views/edit_profile.dart';

// Profile page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //get screen size configuration
    SizeConfig().init(context);
    //double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    int currentIndex = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      //Navigator Bar
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),

      appBar: AppBar(
        title: const Text(
          'Profile page',
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: sizeV * 5),
            const CircleAvatar(
              radius: 45.0,
              backgroundImage:
                  AssetImage('assets/images/profile_page/profile.png'),
            ),
            SizedBox(height: sizeV * 2),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SetPhotoOrVideoScreen()),
                );
              },
              child: Text(
                'Set new Photo or Video',
                style: profileBlueTitle,
              ),
            ),
            SizedBox(height: sizeV * 2),
            const CardViewSingleLabel(cardName: 'Uditha'),
            const CardViewSingleLabel(cardName: 'Bodhinayake'),
            const SizedBox(height: 20),
            Text(
              'Enter your name and add an optional profile photo or '
              'video',
              style: profileGreyInstructions,
            ),
            SizedBox(height: sizeV * 2),
            const CardViewDoubleLabel(
                title: 'Change Number', value: '+94703568837'),
            const CardViewDoubleLabel(title: 'Username', value: '@Uditha'),
            SizedBox(height: sizeV * 2),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AddPetScreen()),
                // );
              },
              child: Text(
                'Add New Pet',
                style: profileBlueTitle,
              ),
            ),
            SizedBox(height: sizeV * 2),
            Text(
              'You can add upto any number of pets',
              style: profileGreyInstructions,
            ),

            SizedBox(
              height: sizeV * 2,
            ),
            const Center(child: LogOutWidget()),//logout widget

            SizedBox(height: sizeV * 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUsScreen()),
                    );
                  },
                  child: Text(
                    'Contact Us',
                    style: profileBlueBody,
                  ),
                ),
                Text(' & ', style: profileBlueBody),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpCenterScreen()),
                    );
                  },
                  child: Text('Help Center', style: profileBlueBody),
                ),
              ],
            ),
            SizedBox(
              height: sizeV * 3,
            ),
          ],
        ),
      ),
    );
  }
}
