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
      //print(Uri.parse(serverUri.origin.toString()+'/health'));
      //this will alter the initial server url to use the /health endpoint
      //(as an example http://127.0.0.1:1337/parse URI will be altered to
      //http://127.0.0.1:1337/health).
      var response =
          await http.get(Uri.parse(serverUri.origin.toString() + '/health'));
      //this will print the statuscode of the respond of server.
      //print(response.statusCode);
      // if server responce is ok return true, otherwise return false.
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

  // this method will send a sample object to the parse server.
  static Future<void> sendSampleObjectToServer() async {
    var firstObject = ParseObject('Sandeepaff1')
      ..set('message', 'Hi brothers. Parse is now connected');
    await firstObject.save();
    //print('Done');
  }
}
