import 'dart:convert';
import 'package:barkmeow/AppConfiguration/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/**
 * This class will check the server status.
 * If the server is running or down. 
 */

class ServerStatus {
  // This method will send http GET request and check whether server is responding
  // with 200 status code which indicates 'OK'. That means server is running.
  static Future<bool> isServerUp(AppConfig config) async {
    try {
      final response =
          await http.get('https://your-server-endpoint.com/status');
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        return responseJson['status'] == 'OK';
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> sendSampleObjectToServer(AppConfig config) async {
    await Parse().initialize(config.keyApplicationId, config.keyParseServerUrl,
        clientKey: config.keyClientKey, autoSendSessionId: true);

    var firstObject = ParseObject('Sandeepa')
      ..set('message', 'Hi brothers. Parse is now connected');
    await firstObject.save();

    print('Done');
  }
}
