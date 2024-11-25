import 'package:expriview/views/start_interview_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.signal_cellular_alt, color: Colors.black),
                        SizedBox(width: 4),
                        Icon(Icons.wifi, color: Colors.black),
                        SizedBox(width: 4),
                        Icon(Icons.battery_full, color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              // Greeting
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hi, James',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              // Search Bar - Styled to match "Start Interview" card
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find previous test...',
                        hintStyle: TextStyle(
                            color: Colors.grey), // Change hint text color here
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        filled: false,
                      ),
                    ),
                  ),
                ),
              ),
              // Card - Start Interview Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.network(
                          'https://storage.googleapis.com/a1aa/image/jVkXDoWO6O4SEpzOfq8wlmnP64PxbXCJbQjMQ3W4tLrMjK3JA.jpg',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      10.0), // Reduced bottom padding here as well
                              child: Text(
                                'Start Interview?',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const StartInterviewPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18.0),
                                backgroundColor: Colors.blue,
                                elevation: 2,
                                foregroundColor:
                                    Colors.white, // Change text color to white
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Column(
                                children: [
                                  Text('Go to Interview Page'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
