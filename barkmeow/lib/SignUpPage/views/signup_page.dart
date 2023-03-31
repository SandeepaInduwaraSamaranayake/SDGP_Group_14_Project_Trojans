import 'package:barkmeow/Login/login_screen.dart';
import 'package:barkmeow/SignUpPage/widgets/head_title.dart';
import 'package:barkmeow/Golbal_Widgets/customized_button.dart';
import 'package:barkmeow/Golbal_Widgets/customized_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:barkmeow/size_configs.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/SignUpPage/widgets/back_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.grey,
                    ),
                    const Text("Or Login with",
                        style: TextStyle(color: Color(0XFF6A707C))),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.15,
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
                      text: "Sign up with Google",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 2),
                    SignInButton(
                      Buttons.Facebook,
                      text: "Sign up with Facebook",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              /*SizedBox(
                height: 100,
              ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 8, 8, 8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color(0XFF6A707C),
                          //fontSize: 15
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
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
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
