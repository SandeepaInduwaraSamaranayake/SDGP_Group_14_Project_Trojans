import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/ServerConnection/connection.dart';
import 'package:barkmeow/SignUpPage/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barkmeow/Onboarding_screens/views/pages.dart';
import 'package:barkmeow/Profile_Page/views/profile_page.dart';

// To hold boolean value whether the user have seen the onboard screens or not.
bool? seenOnboard;

void main() async {
  // Bind method of a Flutter app to initialize the binding of the Flutter
  // framework before running the app.This function makes sure that various
  // important resources required by Flutter, such as the rendering engine and
  // the framework's event loop, are set up properly and are ready to be used.
  WidgetsFlutterBinding.ensureInitialized();

  // To show status bar and bottem navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  // To load the onboarding screens first time only
  SharedPreferences pref = await SharedPreferences.getInstance();
  // If shared preferences seenOnboard variable is null, set it to false.
  seenOnboard = pref.getBool('seenOnboard') ?? false;

  // create a parse server object.
  ParseServerConnection();

  // finally launch application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // printing keys
    // print(config!.keyApplicationId);
    // print(config!.keyClientKey);
    // print(config!.keyParseServerUrl);

    return MaterialApp(
      title: 'BarkMeow',
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        fontFamily: "Poppins",
      ),
      home: seenOnboard == true ? const SignUpScreen() : const HomePage(),
    );
  }
}
