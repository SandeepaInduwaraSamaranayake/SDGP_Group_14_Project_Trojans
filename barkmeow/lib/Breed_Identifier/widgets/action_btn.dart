import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Icon icon;

  const ActionButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.photo_camera,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
