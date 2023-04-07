//Help Center
import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('How to use feature 1'),
            subtitle: Text('Step-by-step instructions on how to use feature 1.'),
          ),
          ListTile(
            title: Text('How to use feature 2'),
            subtitle: Text('Step-by-step instructions on how to use feature 2.'),
          ),
          ListTile(
            title: Text('FAQs'),
            subtitle: Text('Answers to frequently asked questions.'),
          ),
        ],
      ),
    );
  }
}
