import 'dart:io';
import 'package:barkmeow/Golbal_Widgets/camera_action_btn.dart';
import 'package:barkmeow/Contact_Us/views/contact_us_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:barkmeow/Golbal_Widgets/gallary_action_button.dart';
import 'package:barkmeow/Help_Center/views/pages.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/Golbal_Widgets/message.dart';
import 'package:barkmeow/SignIn_Page/views/facebook_login.dart';
import 'package:flutter/foundation.dart';
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
import '../../About_us_page/about_us.dart';

// Profile page
// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  late File profilePicture;
  final ImagePicker _picker =
      ImagePicker(); // to hold the image picker() object.

  // get the current user from parseUser.
  Future<ParseUser?> getUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  // if user facebook name has more than two words get the first
  // and last names only.
  List<String> splitName(String name) {
    List<String> nameList = name.split(' ');
    if (nameList.length > 2) {
      return [
        nameList[0],
        nameList[nameList.length - 1],
      ];
    } else {
      return [
        nameList[0],
        nameList[1],
      ];
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
    int currentIndex = 4;

    // set image to as the user profile image
    Future<void> uploadProfileImage() async {
      final currentUser = await ParseUser.currentUser();

      if (currentUser != null && profilePicture != null) {
        final parseFile =
            ParseFile(profilePicture, name: 'profile_picture.jpg');
        try {
          await parseFile.save();
          currentUser.set('profilePicture', parseFile);
          await currentUser.save();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture uploaded successfully.'),
            ),
          );
        } on ParseError catch (error) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'An error occurred while uploading the profile picture. $error',
              ),
            ),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a profile picture first.',
            ),
          ),
        );
      }
    }

    // method to get gallary image.
    Future pickGalleryImage() async {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        profilePicture = File(
          pickedFile.path,
        );
        uploadProfileImage();
      }
    }

    // method to get camera image.
    Future pickCameraImage() async {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        profilePicture = File(
          pickedFile.path,
        );
        uploadProfileImage();
      }
    }

    // method to select profile picture.
    Future<void> selectProfilePicture(BuildContext context) async {
      await showDialog(
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
                    padding: EdgeInsets.all(
                      sizeV * 1.5,
                    ),
                    child: InkWell(
                      child: const CameraActionButton(),
                      onTap: () {
                        pickCameraImage();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      sizeV * 1.5,
                    ),
                    child: InkWell(
                      child: const GallaryActionButton(),
                      onTap: () {
                        pickGalleryImage();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
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
                          : snapshot.data?.get('profilePicture') != null
                              ? CachedNetworkImageProvider(
                                  snapshot.data?.get('profilePicture').url(),

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
                        selectProfilePicture(
                          context,
                        );
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
                    SizedBox(
                      height: sizeV * 2,
                    ),
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

                    SizedBox(
                      height: sizeV * 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutUsPage(),
                              ),
                            );
                          },
                          child: Text(
                            'About Us',
                            style: profileBlueBody,
                          ),
                        ),
                        Text(' & ', style: profileBlueBody),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpCenterPage(),
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
