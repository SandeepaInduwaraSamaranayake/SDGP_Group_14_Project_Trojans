import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:barkmeow/Golbal_Widgets/message.dart';

class GoogleSignInHelper {
  static void doSignInSignInGoogle(BuildContext context) async {
    late ParseResponse parseResponse;
    try {
      // Check if the user is logged in.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
      if (googleUser != null) {
        // Logout
        await GoogleSignIn().signOut();
      }

      // Make a login request
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();

      if (account == null) {
        // ignore: use_build_context_synchronously
        Message.showError(context: context, message: 'Sign in cancelled.');
        return;
      }

      // Get the Google sign-in authentication tokens
      final GoogleSignInAuthentication googleAuth = await account.authentication;

      // Make sign-in request with Google
      parseResponse = await ParseUser.loginWith(
        'google',
        google(
          googleAuth.accessToken!,
          googleAuth.idToken!,
          googleAuth.serverAuthCode!,
        ),
      );

      if (parseResponse.success) {
        final ParseUser parseUser = await ParseUser.currentUser() as ParseUser;

        // Get user data from Google
        final userData = account;

        // Additional information in user
        parseUser.emailAddress = userData.email;

        if (userData.displayName != null) {
          parseUser.set<String>('name', userData.displayName!);
        }

        if (userData.photoUrl != null) {
          parseUser.set<String>('photoURL', userData.photoUrl!);
        }

        await GoogleSignIn().signOut();
        parseResponse = await parseUser.save();

        if (parseResponse.success) {
          // ignore: use_build_context_synchronously
          Message.showSuccess(
            context: context,
            message: 'User was successfully signed in with Google!',
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
              );
            },
          );
        } else {
          // ignore: use_build_context_synchronously
          Message.showError(
            context: context,
            message: parseResponse.error!.message,
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        Message.showError(
          context: context,
          message: parseResponse.error!.message,
        );
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      Message.showError(context: context, message: e.toString());
    }
  }
}