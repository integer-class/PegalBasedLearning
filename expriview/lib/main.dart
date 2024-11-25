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
    profile.ProfilePage(),
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

  // Example dataMap and colorList for the pie chart
  final Map<String, double> dataMap = {
    "Segment A": 40,
    "Segment B": 30,
    "Segment C": 30,
  };

  final List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  PreviousSessionItem({
    Key? key,
    required this.name,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to ResultDetail when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultDetail(
                      name: name,
                      dataMap: dataMap, // Pass the dataMap
                      colorList: colorList, // Pass the colorList
                    ),
                  ),
                );
              },
              child: const Text('Detail'),
            ),
          ],
        ),
      ),
    );
  }
}