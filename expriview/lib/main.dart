import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'views/home/home_screen.dart' as home;
import 'views/start_interview_page.dart' as interview;
import 'views/results_page.dart' as result;
import 'views/profile_page.dart' as profile;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expriview',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
      ),
      home: const EntryPoint(),
    );
  }
}

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;

  // Define the _pages variable and populate it with the corresponding pages
  static final List<Widget> _pages = [
    const home.HomeScreen(),
    const interview.StartInterviewPage(),
    result.ResultsPage(),
    const profile.ProfilePage(),
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 10, // Left margin outside the navbar
          right: 10, // Right margin outside the navbar
          bottom: 10, // Bottom margin outside the navbar
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color:
                  const Color.fromARGB(255, 255, 255, 255), // Navbar background
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow opacity
                  blurRadius: 0,
                  offset: const Offset(4, 4), // Slight shadow offset
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: 10,
              ),
              child: GNav(
                backgroundColor:
                    Colors.transparent, // Keep navbar background transparent
                color: const Color(0xFF5A7590),
                activeColor: const Color(0xFF2E77AE),
                tabBackgroundColor: const Color(0xFFF2F7FF),
                gap: 10,
                padding: const EdgeInsets.all(10),
                onTabChange: _changeTab,
                tabs: const [
                  GButton(icon: Icons.home, text: 'Home'),
                  GButton(icon: Icons.videocam, text: 'Recording'),
                  GButton(icon: Icons.assessment, text: 'Results'),
                  GButton(icon: Icons.person, text: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
