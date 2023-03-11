import 'package:BarkMeow/widgets/customized_textField.dart';
import 'package:flutter/material.dart';

import '../widgets/customized_button.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
           decoration: BoxDecoration( 
          image: DecorationImage(image: AssetImage("assets/images/login/loginBackground.png")
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
                child: Text("Welcome back! Glad \nto see you, Again!",style: TextStyle(
                  color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Nexa"
                )),
              ),
              CustomizedTextfield(myController: _emailController,hintText: "Enter your Email",isPassword: false,),
              CustomizedTextfield(myController: _passwordController,hintText: "Enter your Password",isPassword: true,),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Text("Forgot Password?",
                  style: TextStyle(
                    color: Color(0XFF6A707C),
                    fontSize: 15,
                  ),
                  ),
                ),
              ),

            CustomizedButton(
              buttonText: "Sign up",
              buttonColor: Colors.orange,
              textColor: Colors.black,
              onPressed: (){
              
            },
          )
          ],
          ),
        ),
      ),
    );
  }
}