import 'package:barkmeow/Login/login_screen.dart';
import 'package:barkmeow/SignIn_Page/views/facebook_login.dart';
import 'package:barkmeow/Golbal_Widgets/head_title.dart';
import 'package:barkmeow/Golbal_Widgets/customized_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  buttonColor: Colors.orange,
                  textColor: Colors.black,
                  onPressed: () => doUserRegistration(),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05), //20
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: screenWidth * 0.34,
                        color: Colors.grey,
                      ),
                      const Text(
                        "Or Sign In with",
                        style: TextStyle(
                          color: Color(0XFF6A707C),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: screenWidth * 0.34,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01), //8
                        child: SignInButton(
                          Buttons.Google,
                          text: "Sign In with Google",
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01), //8
                        child: SignInButton(
                          Buttons.Facebook,
                          text: "Sign In with Facebook",
                          onPressed: () async {
                            try {
                              FacebookLoginHelper.doSignInSignUpFacebook(
                                  context);
                              // Use the Facebook access token to authenticate the user in your app
                            } catch (e) {
                              // Handle login errors
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
                      vertical: screenHeight * 0.005),
                  child: Row(
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color(0XFF6A707C),
                          fontSize: 15,
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
                        child: const Text(
                          "Login.",
                          style: TextStyle(
                            color: Colors.orange,
                            //fontSize: 15
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
                  showSuccess();
                } else {
                  showError(response.error!.message);
                }
              } else {
                showError(validationResponse);
              }
            } else {
              showError("Password confirmation failed!");
            }
          } else {
            showError("You should confirm password!");
          }
        } else {
          showError("Password should be filled!");
        }
      } else {
        showError("Email should be filled!");
      }
    } else {
      showError("Username should be filled!");
    }
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: const Text("User was successfully created!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
