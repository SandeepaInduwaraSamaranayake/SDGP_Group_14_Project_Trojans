import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'Welcome to the About Us page of the BarkMeow app!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'BarkMeow is a pet-friendly social media platform that allows pet owners to connect with each other, share pictures and stories of their furry friends, and discover pet-friendly locations in their area. The app was developed by a team of passionate pet lovers who wanted to create a safe and fun space for pet owners to connect with each other and share their love for their pets.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'At BarkMeow, we understand that pets are more than just animals - they are beloved family members who bring joy and companionship to our lives. That\'s why we\'ve created a platform that celebrates the special bond between pets and their owners, and connects pet lovers from all over the world.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'To learn more about the BarkMeow app or to get in touch with us, please visit our Contact Us page. You can also connect with us on social media by following our Facebook, Instagram, and Twitter accounts, which you can find by clicking the icons below.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Developed by',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Team Trojans SE-14',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Contact Us',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Follow us on social media to stay up-to-date with the latest news and updates from BarkMeow!',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                              'assets/images/About_Us/facebook.png'),
                          onPressed: () async {
                            const url = 'https://www.facebook.com';
                            await launch(url);
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                              'assets/images/About_Us/instagram.jpg'),
                          onPressed: () async {
                            const url = 'https://www.instagram.com';
                            await launch(url);
                          },
                        ),
                        IconButton(
                          icon:
                              Image.asset('assets/images/About_Us/twitter.png'),
                          onPressed: () async {
                            const url = 'https://www.twitter.com';
                            await launch(url);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
