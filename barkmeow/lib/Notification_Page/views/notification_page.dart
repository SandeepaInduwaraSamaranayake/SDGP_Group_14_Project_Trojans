import 'package:flutter/material.dart';
import '../../Bottom_navigator_bar/views/bottom_navigation_bar.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: const Center(
        child: Text('Notification Page'),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}