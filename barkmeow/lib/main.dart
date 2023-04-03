import 'package:barkmeow/AppConfiguration/app_config.dart';
import 'package:barkmeow/AppConfiguration/server_status.dart';
import 'package:barkmeow/Home_Page/views/home_page.dart';
import 'package:barkmeow/SignUpPage/views/pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barkmeow/Onboarding_screens/views/pages.dart';
import 'package:barkmeow/Profile_Page/views/profile_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// To hold boolean value whether the user have seen the onboard screens or not.
bool? seenOnboard;

// declaring and initialising running mode. can be 'local' or 'remote'.
// **** If you are using local  backend server use 'local'  ****
// **** If you are using remote backend server use 'remote' ****
// update local.json or remote.json files according to your server configuration.
// if you are running local parse server, you need to confgure port forwarding
// (add a port forward rule) in your router to accept the parse server connections.
// - src port - your outside device parse server requesting port (normally 1337).
// - Dest. IP Address - your computer ip address(e.g. 192.168.8.117)(use 'ipconfig' command in cmd).
// - Dest. Port - your local computer parse server running port(normally 1337).
// - Protocol - must be UDP + TCP.
// - Comment - Description about this port forwarding rule.
String runningMode = 'local';

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

  // load our configuration at the beginning of the app.
  config = await loadConfig(runningMode);

  // create connection to parse server
  // ! creates a null check.
  // ! (Null assertion operator), we are essentially telling the Dart compiler to
  // "trust" that the value we're referring to will not be null, and to throw an
  // exception if it is.
  await Parse().initialize(config!.keyApplicationId, config!.keyParseServerUrl,
      clientKey: config!.keyClientKey, autoSendSessionId: true, debug: true);

  // check parse obejct is initialized.
  print(Parse().hasParseBeenInitialized());

  // This verifyParseServer() method will check whether server is running or down.
  // If the server is down please double check the assets/local.json and assets/remote.json, for
  // configuration issues. assets/local.json keyParseServerUrl should be using your
  // local nodejs server's ip address.
  // assets/remote.json file will use your remote parse server.
  ServerStatus.verifyParseServer();

  // Send object to the server to test server is responding.
  // ServerStatus.sendSampleObjectToServer();

  // initialiaze the facebook javascript SDK
  if (kIsWeb) {
    FacebookAuth.instance.webAndDesktopInitialize(
      appId: "169504679295813", //<-- FACEBOOK APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }

  // finally launch application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //check user is logged in or not.
  static Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      print("Not logged into an account currently");
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

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
      //home: seenOnboard == true ? const SignUpScreen() : const HomePage(),
      home: seenOnboard == true
          ? FutureBuilder<bool>(
              future: hasUserLogged(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Scaffold(
                      body: Center(
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator()),
                      ),
                    );
                  default:
                    if (snapshot.hasData && snapshot.data!) {
                      return const HomePage();
                    } else {
                      return const SignUpScreen();
                    }
                }
              })
          : const OnBoardingPage(),
    );
  }
}
