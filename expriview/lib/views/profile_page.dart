import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "Loading...";
  String email = "Loading...";
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadEmail();
  }

  Future<void> loadUsername() async {
    final fetchedUsername = await _authService.fetchUsername();
    setState(() {
      username = fetchedUsername;
    });
  }

  Future<void> loadEmail() async {
    final fetchedEmail = await _authService.fetchEmail();
    setState(() {
      email = fetchedEmail;
    });
  }

  void _changeEmail() async {
    await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        String newEmail = "";
        String currentPassword = "";

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Change Email'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      newEmail = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'New Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      currentPassword = value;
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final authService = AuthService();

                  try {
                    await authService.changeEmail(newEmail, currentPassword);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Failed to update email: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  void _changePassword() async {
    await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        String newPassword = "";
        String currentPassword = "";

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Change Password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      newPassword = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      currentPassword = value;
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final authService = AuthService();

                  try {
                    await authService.changeEmail(currentPassword, newPassword);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Failed to update Password: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  void _logOut() async {
    final AuthService authService = AuthService();

    try {
      await authService.logout(); 
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          right: 20,
          left: 20,
          bottom: 20,
          ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Change Email'),
                onTap: _changeEmail,
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: _changePassword,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _logOut,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  child: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
