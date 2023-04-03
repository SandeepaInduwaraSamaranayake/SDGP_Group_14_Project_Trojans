import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: Color(0XFF6A707C),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
