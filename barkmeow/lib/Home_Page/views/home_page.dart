import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
      appBar: AppBar(
        title: const Text('Let\'s Give it a Ride'),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://petzbe.com/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              // Hide the CircularProgressIndicator when page is loaded
              setState(() {
                _isLoading = false;
              });
            },
          ),
          // Show the CircularProgressIndicator while page is loading
          _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}
