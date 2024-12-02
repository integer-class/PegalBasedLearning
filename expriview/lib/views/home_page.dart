import 'package:expriview/views/start_interview_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: rive.RiveAnimation.asset(
                "asset/RiveAssets/menu_button.riv",
                onInit: (artboard) {}, // Jika tidak diperlukan, bisa dihapus
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hi, James',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Welcome back! Ready to ace your next interview?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Carousel / Banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
                    height: 180,
                    child: PageView(
                      children: [
                        bannerCard(
                          'https://storage.googleapis.com/a1aa/image/jVkXDoWO6O4SEpzOfq8wlmnP64PxbXCJbQjMQ3W4tLrMjK3JA.jpg',
                          'Master Your Skills!',
                        ),
                        bannerCard(
                          'https://via.placeholder.com/400x180',
                          'Prepare for Your Dream Job!',
                        ),
                        bannerCard(
                          'https://via.placeholder.com/400x180',
                          'Get Insights on Your Performance!',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Quick Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      quickActionButton(Icons.file_copy, 'My Tests'),
                      quickActionButton(Icons.star, 'Favorites'),
                      quickActionButton(Icons.settings, 'Settings'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Start Interview Card
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
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Interview?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StartInterviewPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 18.0),
                              backgroundColor: Colors.blue,
                              elevation: 2,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Go to Interview Page'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerCard(String imageUrl, String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.4),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget quickActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          radius: 30,
          child: Icon(icon, color: Colors.blue, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
