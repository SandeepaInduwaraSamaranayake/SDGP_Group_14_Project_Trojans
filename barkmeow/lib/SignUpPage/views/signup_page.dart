import 'package:barkmeow/Login/login_screen.dart';
import 'package:barkmeow/SignupOrLogin/widgets/customized_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../Home_Page/views/home_page.dart';
import '../../SignupOrLogin/widgets/customized_textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _usernameContoller=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
             decoration: BoxDecoration( 
            image: DecorationImage(image: AssetImage("assets/images/login_or_signup/loginBackground.png")
            )
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius:   BorderRadius.circular(10),
                    ),
                    child: IconButton(icon: Icon(Icons.arrow_back_ios_sharp),  
                    onPressed: (){
                      Navigator.pop(context);
                      
                    }),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Hello! Register to get \nStart.",style: TextStyle(
                    color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Nexa"
                  )),
                ),

                CustomizedTextfield(myController: _usernameContoller,hintText: "Enter Username",isPassword: false,),
                CustomizedTextfield(myController: _emailController,hintText: "Enter Email",isPassword: false,),
                CustomizedTextfield(myController: _passwordController,hintText: "Enter Password",isPassword: true,),
                CustomizedTextfield(myController: _confirmPasswordController,hintText: "Confirm Password",isPassword: true,),
        
              CustomizedButton(
                buttonText: "Sign Up",
                buttonColor: Colors.orange,
                textColor: Colors.black,
                onPressed: (){

              },
            ),
        
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.height*0.15,
                    color: Colors.grey,
                  ),

                  const Text("Or Login with", style: TextStyle(color: Color(0XFF6A707C))),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.height*0.15,
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
                  SizedBox(height: 2),
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
              padding: const EdgeInsets.fromLTRB(40,8,8,8.0),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Text("Already have an account?",style: TextStyle(
                      color: Color(0XFF6A707C),
                      //fontSize: 15
                    ),),
                    InkWell(
                      onTap:(){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (_)=> const LoginScreen())
                        );
                      }, 
                      child: Text("Login.",style: TextStyle(
                        color: Colors.orange,
                        //fontSize: 15
                      ),),
                    )
                  ],
                ),
              ),
            ),
            ],
            ),
          ),
        ),
      ),
    )
    );
  }
}