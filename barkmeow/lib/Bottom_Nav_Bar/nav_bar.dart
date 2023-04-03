import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/Breed_Identifier/views/controller.dart';
import 'package:barkmeow/Profile_Page/views/pages.dart';
import 'package:barkmeow/SignUpPage/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/Help_Center/views/pages.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:barkmeow/Explore_Page/views/explore_page.dart';
import 'package:barkmeow/Notification_Page/views/notification_page.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  // final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    // required this.items,
    this.onTap,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,

      // items: widget.items,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else if (index == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()));
        } else if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BreedIdentifier()));
        } else if (index == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationPage()));
        } else if (index == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_alert),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_sharp),
          label: 'Profile',
        ),
      ],
      selectedItemColor: navigationBarSelectedColor,
      unselectedItemColor: navigationBarNotSelectedColor,
    );
  }
}

//################################################# EXAMPLE OF HOW TO USE BOTTOM NAVIGATION BAR IN YOUR VIEW ####################################################

 
/*TO USE THIS NAVIGATION BAR THROUGHOUT THE APP USE THE FOLLOWING LIKE CODE

import 'package:flutter/material.dart';
import 'package:my_app/bottom_navigation.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello, world!'),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}*/
