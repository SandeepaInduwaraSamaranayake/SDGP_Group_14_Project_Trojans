import 'package:barkmeow/AppConfiguration/server_status.dart';
import 'package:barkmeow/Sign_Up_Page/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:barkmeow/AppConfiguration/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Onboarding_screens/views/pages.dart';

// To hold boolean value whether the user have seen the onboard screens or not.
bool? seenOnboard;

// To hold the configuration of the application.
// ? indicates that config variable is nullable(can be null).
AppConfig? config;

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

  // declaring and initialising running mode. can be 'local' or 'remote'.
  // **** If you are using local  backend server use 'local'  ****
  // **** If you are using remote backend server use 'remote' ****
  // update local.json or remote.json files according to your server configuration.
  String runningMode = 'local';

  // load our configuration at the beginning of the app.
  config = await loadConfig(runningMode);

  // create connection to parse server
  // ! creates a null check.
  // ! (Null assertion operator), we are essentially telling the Dart compiler to
  // "trust" that the value we're referring to will not be null, and to throw an
  // exception if it is.
  await Parse().initialize(config!.keyApplicationId, config!.keyParseServerUrl,
      clientKey: config!.keyClientKey, autoSendSessionId: true);

  // This verifyParseServer() method will check whether server is running or down.
  // If the server is down please double check the local.json and remote.json, for
  // configuration issues. local.json keyParseServerUrl should be using your
  // local nodejs server's ip address.
  // remote.json file will use your remote parse server.
  bool serverIsUp = await ServerStatus.verifyParseServer(
      Uri.parse(config!.keyParseServerUrl));

  // print the status of the server according to the serverIsUp boolean value.
  // *** uncomment if you want ***
  if (serverIsUp) {
    //print('Server is up and running!');
  } else {
    //print('Server is down!');
  }

  // Send object to the server to test server is responding.
  await ServerStatus.sendSampleObjectToServer();

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
      home: seenOnboard == true ? const SignUpPage() : const OnBoardingPage(),
    );
  }
}
