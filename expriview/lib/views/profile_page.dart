import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 16.0),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Human Resources at PT Figma',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.0),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Saved Messages'),
              onTap: () {
                // Handle saved messages
              },
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('Recent Calls'),
              onTap: () {
                // Handle recent calls
              },
            ),
            ListTile(
              leading: Icon(Icons.devices),
              title: Text('Devices'),
              onTap: () {
                // Handle devices
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Handle notifications
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Appearance'),
              onTap: () {
                // Handle appearance
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {
                // Handle language
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy & Security'),
              onTap: () {
                // Handle privacy and security
              },
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text('Storage'),
              onTap: () {
                // Handle storage
              },
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle log out
                },
                child: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}