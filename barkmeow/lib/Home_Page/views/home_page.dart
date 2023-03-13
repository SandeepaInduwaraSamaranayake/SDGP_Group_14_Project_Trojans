// TODO Implement this library.import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../Bottom_navigator_bar/views/bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
