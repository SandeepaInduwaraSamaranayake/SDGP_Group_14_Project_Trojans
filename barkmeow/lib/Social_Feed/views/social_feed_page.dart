//Social feed
import 'package:flutter/material.dart';
import "package:barkmeow/Bottom_Nav_Bar/nav_bar.dart";

//Social feed
class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social feed'),
      ),
      body: const Center(
        child: Text('Social feed'),
      ),

      backgroundColor: Colors.white,

      //Navigator Bar
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
    );
  }
}
