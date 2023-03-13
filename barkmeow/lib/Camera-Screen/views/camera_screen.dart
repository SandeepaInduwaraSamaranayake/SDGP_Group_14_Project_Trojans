import 'package:flutter/material.dart';
import '../../Bottom_navigator_bar/views/bottom_navigation_bar.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CameraScreen'),
      ),
      body: const Center(
        child: Text('CameraScreen'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      );
  }
}