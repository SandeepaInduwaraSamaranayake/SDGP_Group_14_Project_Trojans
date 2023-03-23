//log Out
import 'package:flutter/material.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Out'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              //await FirebaseAuth.instance.signOut();
              // Navigate back to login screen or any other screen
            } catch (e) {
              print(e.toString());
            }
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
