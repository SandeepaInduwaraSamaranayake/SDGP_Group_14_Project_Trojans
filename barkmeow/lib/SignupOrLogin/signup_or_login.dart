import 'package:barkmeow/Login/login_screen.dart';
import 'package:barkmeow/SignUpPage/views/pages.dart';
import 'package:barkmeow/SignupOrLogin/widgets/customized_button.dart';
import 'package:flutter/material.dart';

class LoginOrSignupPage extends StatelessWidget {
  const LoginOrSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration( 
          image: DecorationImage(image: AssetImage("assets/images/common/welcomeBackground.png")
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          // const SizedBox(
          //   height: 200,
          //   width: 200,
          //   child: Image(image: AssetImage("assets/images/welcome/logo2-2.png")),
          // ),
          const SizedBox(
            height: 40,
          ),
          CustomizedButton(
            buttonText: "Login",
            buttonColor: Colors.black,
            textColor: Colors.white,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          ),
           CustomizedButton(
            buttonText: "Sign up",
            buttonColor: Colors.orange,
            textColor: Colors.black,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
              
            },
          )
          
        ],
      ),
      ),
      
    );
  }
}