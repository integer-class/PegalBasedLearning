import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profiles'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Jaehyun Myung',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Human Resources at PT Figma',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24.0),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Saved Messages'),
              onTap: () {
                // Handle saved messages
              },
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text('Recent Calls'),
              onTap: () {
                // Handle recent calls
              },
            ),
            ListTile(
              leading: const Icon(Icons.devices),
              title: const Text('Devices'),
              onTap: () {
                // Handle devices
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                // Handle notifications
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Appearance'),
              onTap: () {
                // Handle appearance
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              onTap: () {
                // Handle language
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Privacy & Security'),
              onTap: () {
                // Handle privacy and security
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle log out
                },
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
