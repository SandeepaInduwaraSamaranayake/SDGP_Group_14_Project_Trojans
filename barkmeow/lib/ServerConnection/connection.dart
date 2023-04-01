import 'package:barkmeow/AppConfiguration/app_config.dart';
import 'package:barkmeow/AppConfiguration/server_status.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

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

// create connection variables.
late String appId;
late String serverUrl;
late String clientKey;

// create a Parse server connection instance.
Parse parse = Parse();

class ParseServerConnection {
  ParseServerConnection() {
    // load our configuration at the beginning and then setup the server.
    loadConfig(runningMode).then(
      (configuration) async {
        // get the configuration
        config = configuration;

        // assign configuration
        appId = config!.keyApplicationId;
        serverUrl = config!.keyParseServerUrl;
        clientKey = config!.keyClientKey;

        // create connection to parse server
        // ! creates a null check.
        // ! (Null assertion operator), we are essentially telling the Dart compiler to
        // "trust" that the value we're referring to will not be null, and to throw an
        // exception if it is.
        await parse.initialize(
          appId,
          serverUrl,
          clientKey: clientKey,
          autoSendSessionId: true,
          debug: true,
        );

        // check parse obejct is initialized.
        print(parse.hasParseBeenInitialized());

        // This verifyParseServer() method will check whether server is running or down.
        // If the server is down please double check the assets/local.json and assets/remote.json, for
        // configuration issues. assets/local.json keyParseServerUrl should be using your
        // local nodejs server's ip address.
        // assets/remote.json file will use your remote parse server.
        ServerStatus.verifyParseServer();

        // Send object to the server to test server is responding.
        // ServerStatus.sendSampleObjectToServer();
      },
    );
  }
}
