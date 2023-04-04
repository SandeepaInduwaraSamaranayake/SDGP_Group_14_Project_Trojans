import 'package:barkmeow/Profile_Page/views/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:barkmeow/size_configs.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //get screen size configuration
    SizeConfig().init(context);
    double screenWidth = SizeConfig.screenWidth!;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.all(
          screenWidth * 0.02, //8.0
        ),
        child: InkWell(
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: forgotPasswordGreytxtColor,
              fontSize: screenWidth * 0.03, //15
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ResetPasswordPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
