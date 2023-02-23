import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  // declare variables to hold keys and urls.
  final String keyApplicationId;
  final String keyClientKey;
  final String keyParseServerUrl;

  AppConfig({
    required this.keyApplicationId,
    required this.keyClientKey,
    required this.keyParseServerUrl,
  });

// convert our JSON into an instance of our AppConfig class1
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      keyApplicationId: json['keyApplicationId'],
      keyClientKey: json['keyClientKey'],
      keyParseServerUrl: json['keyParseServerUrl'],
    );
  }
}

Future<AppConfig> loadConfig(String mode) async {
  // Load the appropriate JSON file
  String configString =
      await rootBundle.loadString('assets/environment_config/$mode.json');

  // Parse the JSON file
  Map<String, dynamic> config = json.decode(configString);

  // Return the Config object
  return AppConfig.fromJson(config);
}
