import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'views/home_page.dart';
import 'views/results_page.dart';
import 'views/start_interview_page.dart';
import 'views/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const HomePage(),
    const StartInterviewPage(),
    const ResultsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpriView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          height: 75,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: GNav(
              backgroundColor: Colors.white,
              color: const Color(0xFF5A7590),
              activeColor: const Color(0xFF2E77AE),
              tabBackgroundColor: const Color(0xFFF2F7FF),
              gap: 10,
              padding: const EdgeInsets.all(20),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.view_list_rounded,
                  text: 'Interview',
                ),
                GButton(
                  icon: Icons.assessment,
                  text: 'Results',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
