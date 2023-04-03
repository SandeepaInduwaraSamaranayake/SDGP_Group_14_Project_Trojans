import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

/// This class will check the server status.
/// If the server is running or down.
class ServerStatus {
  // This method will send http GET request and check whether server is responding
  // with 200 status code which indicates 'OK'. That means server is running.
  static Future<void> verifyParseServer() async {
    final apiResponse = await Parse().healthCheck();
    if (apiResponse.success) {
      print('Server is up and running!');
    } else {
      print('Server is down!');
    }
  }

  // this method will send a sample object to the parse server.
  // static Future<void> sendSampleObjectToServer() async {
  //   var firstObject = ParseObject('User')
  //     ..set('message', 'sandeepa')
  //     ..set('password', 'hello')
  //     ..set('emailVerified', false);

  //   await firstObject.save();
  //   try {
  //    final ParseResponse parseResponse = await firstObject.save();

  //    if(parseResponse.success)
  //    {
  //     var objectId = (parseResponse.results!.first as ParseObject).objectId!;
  //     print('Object created: $objectId');
  //    }
  //     print('Sample object sent to Parse Server!');
  //   } catch (e) {
  //     print('Error sending sample object to Parse Server: $e');
  //   }
  // }
}
