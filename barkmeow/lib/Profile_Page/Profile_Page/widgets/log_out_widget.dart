import 'package:flutter/material.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1,
            child: IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const LogOutScreen()),
                // );
              },
              icon: const Icon(Icons.add_to_home_screen),
              color: Colors.cyan,
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const LogOutScreen()),
              // );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 28.0),
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
