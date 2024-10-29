import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Mainwrapper extends StatefulWidget {
  const Mainwrapper({super.key});

  @override
  State<Mainwrapper> createState() => _MainwrapperState();
}

class _MainwrapperState extends State<Mainwrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blue,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.videocam, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}
