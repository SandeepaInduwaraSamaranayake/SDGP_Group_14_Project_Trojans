import 'package:flutter/material.dart';
import 'package:barkmeow/Bottom_Nav_Bar/nav_bar.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notifications = [    "Notification 1",    "Notification 2",    "Notification 3",    "Notification 4",    "Notification 5",  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = 3;
    return Scaffold(
      backgroundColor: Colors.white,
      //Navigator Bar
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
      ),
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                notifications[index],
                style: const TextStyle(fontSize: 18.0),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
