import 'dart:io';
import 'package:barkmeow/Golbal_Widgets/camera_action_btn.dart';
import 'package:barkmeow/Golbal_Widgets/gallary_action_button.dart';
import 'package:barkmeow/Golbal_Widgets/get_input.dart';
import 'package:barkmeow/Help_Center/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:barkmeow/Profile_Page/widgets/card_view_double_label.dart';
import 'package:barkmeow/Profile_Page/widgets/card_view_single_label.dart';
import 'package:barkmeow/Profile_Page/widgets/log_out_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:barkmeow/About_us_page/about_us.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// Profile page
// ignore: must_be_immutable
class _ProfilePageState extends State<ProfilePage> with ChangeNotifier {
  late File profilePicture;
  String firstName = '';
  late String lastName = '';
  final ImagePicker _picker =
      ImagePicker(); // to hold the image picker() object.

  late ImageProvider<Object> profileImage;

  @override
  void initState() {
    super.initState();
    _getUserProfileImage();
    _getUserNames();
  }

  // this method will set the profile image
  void _getUserProfileImage() {
    getUser().then(
      (user) {
        if (user != null) {
          // set profile picture
          if (user.get('profilePicture') is ParseFile) {
            profileImage = NetworkImage(
              (user.get('profilePicture') as ParseFile).url!,
            );
          } else {
            if (user.get('photoURL') != null) {
              profileImage = NetworkImage(user.get('photoURL'));
            } else {
              profileImage =
                  const AssetImage('assets/images/profile_page/profile.png');
            }
          }
        }
      },
    );
  }

  // this method will set the user name.
  void _getUserNames() {
    getUser().then(
      (user) {
        if (user != null) {
          // set first and last name
          firstName = user.get('firstName');
          lastName = user.get('lastName');
        }
      },
    );
  }

  // this method will set the first name in the cloud database
  void _setFirstName() {
    getUser().then(
      (user) {
        if (user != null) {
          // set first and last name
          user.set('firstName', firstName);
          user.save();
        }
      },
    );
  }

  // this method will set the last name in the cloud database
  void _setLastName() {
    getUser().then(
      (user) {
        if (user != null) {
          // set last name
          user.set('lastName', lastName);
          user.save();
        }
      },
    );
  }

  // get the current user from parseUser.
  Future<ParseUser?> getUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

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
          // upload user selected profile picture to server.
          await parseFile.save();
          currentUser.set('profilePicture', parseFile);
          await currentUser.save();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture uploaded successfully.'),
            ),
          );
          // set user selected profile to user profile page.
          setState(() {
            profileImage = FileImage(profilePicture);
          });
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
                      backgroundImage: (snapshot.data?.get('profilePicture')
                              is ParseFile)
                          ? NetworkImage((snapshot.data?.get('profilePicture')
                                  as ParseFile)
                              .url!)
                          : (snapshot.data?.get('photoURL') != null)
                              ? NetworkImage(
                                  snapshot.data?.get('photoURL'),
                                )
                              : const AssetImage(
                                      'assets/images/profile_page/profile.png')
                                  as ImageProvider<Object>,
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
                    GestureDetector(
                      onTap: () async {
                        String enteredFirstName =
                            await DialogHelper.showInputDialog(
                                context, "Enter Your First Name");
                        // set user selected profile to user profile page.
                        setState(() {
                          firstName =
                              enteredFirstName; // update the local firstname.
                          _setFirstName(); // update the remote firstname.
                        });
                      },
                      child: CardViewSingleLabel(
                          cardName: snapshot.data?.get('firstName') != null
                              ? firstName
                              : "Set Your First Name"),
                    ),

                    GestureDetector(
                      onTap: () async {
                        String enteredLastName =
                            await DialogHelper.showInputDialog(
                                context, "Enter Your Last Name");
                        // set user selected profile to user profile page.
                        setState(() {
                          lastName =
                              enteredLastName; // update the local firstname.
                          _setLastName(); // update the remote firstname.
                        });
                      },
                      child: CardViewSingleLabel(
                          cardName: snapshot.data?.get('lastName') != null
                              ? lastName
                              : "Set Your Last Name"),
                    ),
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
                      value: snapshot.data?.emailAddress.toString() ??
                          'Not set yet',
                    ),
                    CardViewDoubleLabel(
                      title: 'Username',
                      value:
                          snapshot.data?.username.toString() ?? 'Not set yet',
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
