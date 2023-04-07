import 'package:flutter/material.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
      appBar: AppBar(
        title: const Text('Share What you Love'),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://petzbe.store/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              // Hide the CircularProgressIndicator when page is loaded
              setState(() {
                _isLoading = false;
              });
            },
          ),
          // Show the CircularProgressIndicator while page is loading
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
