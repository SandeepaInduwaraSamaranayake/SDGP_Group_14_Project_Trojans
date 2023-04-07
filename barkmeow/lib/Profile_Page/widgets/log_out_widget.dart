import 'package:barkmeow/Golbal_Widgets/message.dart';
import 'package:barkmeow/SignupOrLogin/signup_or_login.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // this method will logout the user.
    void doUserLogout() async {
      final currentUser = await ParseUser.currentUser() as ParseUser;
      var response = await currentUser.logout();
      if (response.success) {
        // ignore: use_build_context_synchronously
        Message.showSuccess(
          context: context,
          message: 'User was successfully logout!',
        );
      } else {
        // ignore: use_build_context_synchronously
        Message.showError(context: context, message: response.error!.message);
      }
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1,
            child: IconButton(
              onPressed: () {
                doUserLogout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginOrSignupPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add_to_home_screen),
              color: Colors.cyan,
            ),
          ),
          InkWell(
            onTap: () {
              doUserLogout();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginOrSignupPage(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 28.0),
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
