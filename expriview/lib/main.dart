import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'views/home_page.dart' as home;
import 'views/results_page.dart';
import 'views/start_interview_page.dart' as interview;
import 'views/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const home.HomePage(),
    const interview.StartInterviewPage(),
    const ResultsPage(),
    const ProfilePage(),
  ];

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Bottom Navigation Bar',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
        bottomNavigationBar: Container(
          height: 75,
          width: 750,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.2), // Shadow color
          //       spreadRadius: 5, // Spread radius
          //       blurRadius: 7, // Blur radius
          //       offset: const Offset(0, 3), // Offset for the shadow
          //     ),
          //   ],
          // ),
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: GNav(
              backgroundColor: Colors.white,
              color: Color(0xFF5A7590),
              activeColor: Color(0xFF2E77AE),
              tabBackgroundColor: Color(0xFFF2F7FF),
              gap: 10,
              padding: EdgeInsets.all(20),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Setting',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
