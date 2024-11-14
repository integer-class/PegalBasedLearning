import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'views/home_page.dart' as home;
import 'views/results_page.dart';
import 'views/start_interview_page.dart' as interview;
import 'views/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    home.HomePage(),
    interview.StartInterviewPage(),
    ResultsPage(),
    ProfilePage(),
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
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 188, 220, 245),
          secondary: Colors.green,
        ),
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: ResponsiveNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: changeTab,
          navigationBarButtons: <NavigationBarButton>[
            NavigationBarButton(
              text: 'Home',
              icon:
                  _selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
            ),
            NavigationBarButton(
              text: 'Start',
              icon: _selectedIndex == 1 ? Icons.camera : Icons.camera_alt,
            ),
            NavigationBarButton(
              text: 'Results',
              icon: _selectedIndex == 2 ? Icons.list : Icons.list_alt,
            ),
            NavigationBarButton(
              text: 'Profile',
              icon: _selectedIndex == 3 ? Icons.person : Icons.person_outline,
            ),
          ],
        ),
      ),
    );
  }
}
