import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/screen2');
              break;
            case 2:
              Navigator.pushNamed(context, '/screen3');
              break;
            case 3:
              Navigator.pushNamed(context, '/screen4');
              break;
            case 4:
              Navigator.pushNamed(context, '/screen5');
              break;
          }
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Screen 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Screen 3',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_alert),
          label: 'Screen 3',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Screen 3',
        ),
      ],
      backgroundColor: Colors.grey[300], // Change this line to set the color
    );
  }
}

