import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:barkmeow/SignUpPage/views/message.dart';

class FacebookLoginHelper {
  static void doSignInSignUpFacebook(BuildContext context) async {
    late ParseResponse parseResponse;
    try {
      //Check if the user is logged.
      final AccessToken? currentAccessToken =
          await FacebookAuth.instance.accessToken;
      if (currentAccessToken != null) {
        //Logout
        await FacebookAuth.instance.logOut();
      }

      //Make a Login request
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        Message.showError(context: context, message: result.message!);
        return;
      }

      final AccessToken accessToken = result.accessToken!;

      //https://docs.parseplatform.org/parse-server/guide/#facebook-authdata
      //According to the documentation, we must send a Map with user authentication data.

      //Make sign in with Facebook
      parseResponse = await ParseUser.loginWith('facebook',
          facebook(accessToken.token, accessToken.userId, accessToken.expires));

      if (parseResponse.success) {
        final ParseUser parseUser = await ParseUser.currentUser() as ParseUser;

        //Get user data from Facebook
        final userData = await FacebookAuth.instance.getUserData();

        //Additional Information in User
        if (userData.containsKey('email')) {
          parseUser.emailAddress = userData['email'];
        }

        if (userData.containsKey('name')) {
          parseUser.set<String>('name', userData['name']);
        }
        if (userData["picture"]["data"]["url"] != null) {
          parseUser.set<String>('photoURL', userData["picture"]["data"]["url"]);
        }

        await FacebookAuth.instance.logOut();
        parseResponse = await parseUser.save();

        if (parseResponse.success) {
          Message.showSuccess(
              context: context,
              message: 'User was successfully with Sign In Facebook!',
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
                );
              });
        } else {
          Message.showError(
              context: context, message: parseResponse.error!.message);
        }
      } else {
        Message.showError(
            context: context, message: parseResponse.error!.message);
      }
    } on Exception catch (e) {
      print(e.toString());
      Message.showError(context: context, message: e.toString());
    }
  }

  
}