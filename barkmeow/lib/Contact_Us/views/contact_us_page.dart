//Contact us
import 'package:flutter/material.dart';
import "package:barkmeow/Bottom_Nav_Bar/nav_bar.dart";

//Contact us
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us'),
      ),
      body: const Center(
        child: Text('Contact us'),
      ),

      backgroundColor: Colors.white,

      //Navigator Bar
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
    );
  }
}
