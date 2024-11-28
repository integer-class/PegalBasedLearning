import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'views/home_page.dart' as home;
import 'views/results_page.dart';
import 'views/result_detail.dart';
import 'views/start_interview_page.dart' as interview;
import 'views/profile_page.dart' as profile;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const home.HomePage(),
    const interview.StartInterviewPage(),
    const ResultsPage(),
    const profile.ProfilePage(),
  ];

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          width: double.infinity,
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
              onTabChange: changeTab,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.videocam,
                  text: 'Recording',
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

class PreviousSessionItem extends StatelessWidget {
  final String name;
  final String date;
  final Map<String, double> dataMap; // Added dataMap as a parameter
  final List<Color> colorList; // Added colorList as a parameter

  const PreviousSessionItem({
    Key? key,
    required this.name,
    required this.date,
    required this.dataMap,
    required this.colorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(date),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Navigate to ResultDetail when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultDetail(
                        name: name,
                        dataMap: dataMap, // Pass the dataMap to ResultDetail
                        colorList:
                            colorList, // Pass the colorList to ResultDetail
                      ),
                    ),
                  );
                },
                child: const Text('Detail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
