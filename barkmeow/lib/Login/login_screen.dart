import 'package:barkmeow/Golbal_Widgets/head_title.dart';
import 'package:barkmeow/SignUpPage/views/pages.dart';
import 'package:barkmeow/Golbal_Widgets/back_button.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_textfield.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    // Perform login logic here
    // ...

    // Navigate to HomePage
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const HomePage(),
    //   ),
    // );
  }

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
                  myController: _emailController,
                  hintText: "Enter your Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Enter your Password",
                  isPassword: true,
                ),
                const Align(
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
                ),
                CustomizedButton(
                  buttonText: "Login",
                  buttonColor: Colors.orange,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: screenHeight * 0.15,
                        color: Colors.grey,
                      ),
                      const Text(
                        "Or Login with",
                        style: TextStyle(
                          color: Color(0XFF6A707C),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: screenHeight * 0.15,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        text: "Login with Google",
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Login with Facebook",
                        onPressed: () {},
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
                      const Text(
                        "Don't have an account?",
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
                              builder: (_) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up.",
                          style: TextStyle(
                            color: Colors.orange,
                            //fontSize: 15
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
}
