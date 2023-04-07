import 'dart:async';
import 'package:flutter/material.dart';

class DialogHelper {
  static Future<String> showInputDialog(BuildContext context, String title) {
    Completer<String> completer = Completer();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputText = "";

        return AlertDialog(
          title:  Text(title),
          content: TextField(
            onChanged: (value) {
              inputText = value;
            },
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                completer.complete(inputText);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }
}
