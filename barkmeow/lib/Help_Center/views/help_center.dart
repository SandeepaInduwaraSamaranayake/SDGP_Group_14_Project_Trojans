//Help Center
import 'package:flutter/material.dart';
import "package:barkmeow/Bottom_Nav_Bar/nav_bar.dart";

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help center'),
      ),
      body: const Center(
        child: Text('Help center'),
      ),

      backgroundColor: Colors.white,

      //Navigator Bar
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
    );
  }
}
