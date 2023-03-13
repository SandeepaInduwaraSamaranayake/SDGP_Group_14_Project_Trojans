import 'package:flutter/material.dart';
import '../../Bottom_navigator_bar/views/bottom_navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}