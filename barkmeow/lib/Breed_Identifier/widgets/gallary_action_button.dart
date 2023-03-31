import 'package:flutter/material.dart';

class GallaryActionButton extends StatelessWidget {
  const GallaryActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.photo_library,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}