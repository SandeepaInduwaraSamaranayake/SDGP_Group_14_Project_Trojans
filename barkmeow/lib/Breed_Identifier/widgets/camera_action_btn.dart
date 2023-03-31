import 'package:flutter/material.dart';

class CameraActionButton extends StatelessWidget {
  const CameraActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.camera_alt,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

