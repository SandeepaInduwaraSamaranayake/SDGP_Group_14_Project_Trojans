import 'dart:io';

import 'package:barkmeow/Golbal_Widgets/camera_action_btn.dart';
import 'package:barkmeow/Contact_Us/views/contact_us_page.dart';
import 'package:barkmeow/Golbal_Widgets/gallary_action_button.dart';
import 'package:barkmeow/Help_Center/views/pages.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/Golbal_Widgets/message.dart';
import 'package:barkmeow/SignIn_Page/views/facebook_login.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:barkmeow/Profile_Page/widgets/card_view_double_label.dart';
import 'package:barkmeow/Profile_Page/widgets/card_view_single_label.dart';
import 'package:barkmeow/Profile_Page/widgets/log_out_widget.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Profile page
// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  late File profilePicture;

  // get the current user from parseUser.
  Future<ParseUser?> getUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  // if user facebook name has more than two words get the first
  // and last names only.
  List<String> splitName(String name) {
    List<String> nameList = name.split(' ');
    if (nameList.length > 2) {
      return [nameList[0], nameList[nameList.length - 1]];
    } else {
      return [nameList[0], nameList[1]];
    }
  }

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //get screen size configuration
    SizeConfig().init(context);
    //double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    // current index for nav bar
    int currentIndex = 0;

    // method to select profile picture.
    Future<void> selectProfilePicture(BuildContext context) async {
      final pickedFile = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Select a profile picture',
            ),
            // ignore: prefer_const_constructors
            content: Text(
              'Would you like to take a picture with the camera or choose one from the gallery?',
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(
                          await ImagePicker().pickImage(
                            source: ImageSource.camera,
                          ),
                        );
                      },
                      child: const CameraActionButton(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(
                          await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          ),
                        );
                      },
                      child: const GallaryActionButton(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
      if (pickedFile != null) {
        profilePicture = File(
          pickedFile.path,
        );
      }
    }

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
      body: FutureBuilder<ParseUser?>(
        future: getUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeV * 5,
                    ),
                    CircleAvatar(
                      radius: 45.0,
                      // load networkImage to the interface. if network image is not available.
                      // fallback to an AssetImage.
                      backgroundImage: snapshot.data?.get('photoURL') != null
                          ? NetworkImage(
                              snapshot.data!.get(
                                'photoURL',
                              ),
                            )
                          : const AssetImage(
                              'assets/images/profile_page/profile.png',
                            ) as ImageProvider<Object>,
                    ),
                    SizedBox(
                      height: sizeV * 2,
                    ),
                    InkWell(
                      onTap: () {
                        selectProfilePicture(context);
                      },
                      child: Text(
                        'Set new Photo',
                        style: profileBlueTitle,
                      ),
                    ),
                    SizedBox(
                      height: sizeV * 2,
                    ),
                    // load name of the user. if name is not defined, fallback to 'Not set yet'.
                    CardViewSingleLabel(
                        cardName: snapshot.data!.get('name') != null
                            ? splitName(snapshot.data!.get('name'))[0]
                            : "Not set yet"),
                    CardViewSingleLabel(
                        cardName: snapshot.data!.get('name') != null
                            ? splitName(snapshot.data!.get('name'))[1]
                            : "Not set yet"),
                    const SizedBox(
                      height: 20, //20
                    ),
                    Text(
                      'Enter your name and add an optional profile photo or video',
                      style: profileGreyInstructions,
                    ),
                    SizedBox(
                      height: sizeV * 2,
                    ),
                    CardViewDoubleLabel(
                      title: 'Email',
                      value: snapshot.data!.emailAddress.toString(),
                    ),
                    CardViewDoubleLabel(
                      title: 'Username',
                      value: snapshot.data!.username.toString(),
                    ),
                    SizedBox(
                      height: sizeV * 2,
                    ),
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
                    const Center(
                      child: LogOutWidget(),
                    ), //logout widget

                    SizedBox(height: sizeV * 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ContactUsScreen(),
                              ),
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
                                builder: (context) => const HelpCenterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Help Center',
                            style: profileBlueBody,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeV * 3,
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
