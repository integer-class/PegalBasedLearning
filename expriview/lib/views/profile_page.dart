import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  SizedBox(width: 16.0), // Jarak antara avatar dan teks
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jaehyun Myung',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Human Resources at PT Figma',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
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
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle log out
                  },
                  child: const Text('Log Out'),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
