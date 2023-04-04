import 'package:barkmeow/Golbal_Widgets/BottomSeperater.dart';
import 'package:barkmeow/Golbal_Widgets/message.dart';
import 'package:barkmeow/SignIn_Page/views/login_screen.dart';
import 'package:barkmeow/SignIn_Page/views/facebook_login.dart';
import 'package:barkmeow/Golbal_Widgets/head_title.dart';
import 'package:barkmeow/Golbal_Widgets/customized_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barkmeow/app_styles.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/Golbal_Widgets/back_button.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameContoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
            width: screenWidth,
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
                  title: "Hello! Register to get \nStart.",
                  screenWidth: screenWidth,
                ),
                CustomizedTextfield(
                  myController: _usernameContoller,
                  hintText: "Enter Username",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: "Enter Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Enter Password",
                  isPassword: true,
                ),
                CustomizedTextfield(
                  myController: _confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                ),
                CustomizedButton(
                  buttonText: "Sign Up",
                  buttonColor: signInSignUpBtnColor,
                  textColor: signInSignUpBtnTxtColor,
                  onPressed: () => doUserRegistration(),
                ),
                BottomSeperater(
                  screenWidth: screenWidth,
                  caption: "Or Sign Up with",
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01), //8
                        child: SignInButton(
                          Buttons.Google,
                          text: "Sign Up with Google",
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01), //8
                        child: SignInButton(
                          Buttons.Facebook,
                          text: "Sign Up with Facebook",
                          onPressed: () async {
                            try {
                              FacebookLoginHelper.doSignInSignUpFacebook(
                                  context);
                            } catch (e) {
                              Message.showError(
                                context: context,
                                message: "Error Occurred",
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.25,
                      vertical: screenHeight * 0.02),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: signInSignUpGreytxtColor,
                          fontSize: screenWidth * 0.03, //15
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          " Login.",
                          style: TextStyle(
                            color: signInSignUptxtColor,
                            fontSize: screenWidth * 0.03, //15
                          ),
                        ),
                      )
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

  doUserRegistration() async {
    final username = _usernameContoller.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isNotEmpty) {
      if (email.isNotEmpty) {
        if (password.isNotEmpty) {
          if (confirmPassword.isNotEmpty) {
            if (password == confirmPassword) {
              String? validationResponse = validatePassword(password);
              if (validationResponse == null) {
                final user = ParseUser.createUser(username, password, email);
                var response = await user.signUp();
                if (response.success) {
                  // ignore: use_build_context_synchronously
                  Message.showSuccess(
                    context: context,
                    message: "User was successfully created!",
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Message.showError(
                      context: context, message: response.error!.message);
                }
              } else {
                Message.showError(
                    context: context, message: validationResponse);
              }
            } else {
              Message.showError(
                  context: context, message: "Password confirmation failed!");
            }
          } else {
            Message.showError(
                context: context, message: "You should confirm password!");
          }
        } else {
          Message.showError(
              context: context, message: "Password should be filled!");
        }
      } else {
        Message.showError(context: context, message: "Email should be filled!");
      }
    } else {
      Message.showError(
          context: context, message: "Username should be filled!");
    }
  }

  String? validatePassword(String value) {
    // check for at least 8 characters.
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}
