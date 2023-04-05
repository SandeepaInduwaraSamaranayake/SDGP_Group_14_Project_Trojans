import 'package:barkmeow/Golbal_Widgets/BottomSeperater.dart';
import 'package:barkmeow/Golbal_Widgets/head_title.dart';
import 'package:barkmeow/SignIn_Page/views/facebook_login.dart';
import 'package:barkmeow/SignIn_Page/widgets/forgot_password.dart';
import 'package:barkmeow/SignUpPage/views/pages.dart';
import 'package:barkmeow/Golbal_Widgets/back_button.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_textfield.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/Golbal_Widgets/message.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'google_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //get screen size configuration
    SizeConfig().init(context);
    double screenHeight = SizeConfig.screenHeight!;
    double screenWidth = SizeConfig.screenWidth!;

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ); // <-- This line will block screen rotation

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/login_or_signup/loginBackground.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomizedBackButton(
                  screenWidth: screenWidth,
                ),
                HeadTitle(
                  title: "Welcome back! Glad \nto see you, Again!",
                  screenWidth: screenWidth,
                ),
                CustomizedTextfield(
                  myController: _usernameController,
                  hintText: "Enter your Usrename",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Enter your Password",
                  isPassword: true,
                ),
                const ForgotPassword(),
                CustomizedButton(
                  buttonText: "LogIn",
                  buttonColor: signInSignUpBtnColor,
                  textColor: signInSignUpBtnTxtColor,
                  onPressed: () {
                    // get data from text fields.
                    final username = _usernameController.text.trim();
                    final password = _passwordController.text.trim();
                    doUserLogin(username, password);
                  },
                ),
                BottomSeperater(
                  screenWidth: screenWidth,
                  caption: "Or LogIn with",
                ),
                Center(
                  child: Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        text: "LogIn with Google",
                        onPressed: () {
                          try {
                            GoogleSignInHelper.doSignInSignInGoogle(context);
                          } on PlatformException catch (e) {
                            if (kDebugMode) {
                              print('Platform exception occurred: $e');
                            }
                          } catch (e) {
                            Message.showError(
                              context: context,
                              message: "Error Occurred",
                            );
                          }
                        }
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "LogIn with Facebook",
                        onPressed: () {
                          try {
                            FacebookLoginHelper.doSignInSignUpFacebook(context);
                          } catch (e) {
                            Message.showError(
                              context: context,
                              message: "Error Occurred",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.25,
                      vertical: screenHeight * 0.005),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: signInSignUpGreytxtColor,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          " Sign Up.",
                          style: TextStyle(
                            color: signInSignUptxtColor,
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void doUserLogin(String username, String password) async {
    if (username.isNotEmpty) {
      if (password.isNotEmpty) {
        // creating user object.
        final user = ParseUser(username, password, null);
        // make login the user.
        var response = await user.login();

        if (response.success) {
          // ignore: use_build_context_synchronously
          Message.showSuccess(
              context: context, message: "User was successfully login!");
          // if only login is success, redirect user to the homepage.
          setState(
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
              );
            },
          );
        } else {
          // ignore: use_build_context_synchronously
          Message.showError(context: context, message: response.error!.message);
        }
      } else {
        Message.showError(context: context, message: "Email should be filled!");
      }
    } else {
      Message.showError(
          context: context, message: "Username should be filled!");
    }
  }
}
