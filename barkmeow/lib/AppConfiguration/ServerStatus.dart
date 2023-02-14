import 'dart:io';
import 'package:barkmeow/AppConfiguration/AppConfig.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:http/http.dart' as http;

/**
 * This class will check the server status.
 * If the server is running or down. 
 */

class ServerStatus {
  // This method will send http GET request and check whether server is responding
  // with 200 status code which indicates 'OK'. That means server is running.
  static Future<bool> verifyParseServer(Uri serverUri) async {
    try {
      print(serverUri);
      var response = await http.get(serverUri);
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

// working.
  static Future<void> sendSampleObjectToServer(AppConfig config) async {
    await Parse().initialize(config.keyApplicationId, config.keyParseServerUrl,
        clientKey: config.keyClientKey, autoSendSessionId: true);

    var firstObject = ParseObject('Sandeepa')
      ..set('message', 'Hi brothers. Parse is now connected');
    await firstObject.save();

    print('Done');
  }
}
