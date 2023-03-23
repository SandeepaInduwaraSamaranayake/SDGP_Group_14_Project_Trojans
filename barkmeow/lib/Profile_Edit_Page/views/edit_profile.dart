//Add photo or video
import 'package:flutter/material.dart';

class SetPhotoOrVideoScreen extends StatelessWidget {
  const SetPhotoOrVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Photo or Video'),
      ),
      body: const Center(
        child: Text('Add Photo or Video'),
      ),
    );
  }
}
