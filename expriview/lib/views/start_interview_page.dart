import 'package:flutter/material.dart';
import 'recording_page.dart';

class StartInterviewPage extends StatelessWidget {
  const StartInterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Interview Sessions',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F8F8), Color(0xFFE0E0E0)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            SessionCard(name: 'Riko Saputra'),
            SizedBox(height: 16.0),
            SessionCard(name: 'Maya Sari'),
            SizedBox(height: 16.0),
            SessionCard(name: 'Adi Wirawan'),
          ],
        ),
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final String name;

  const SessionCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecordingPage(
                      intervieweeName: name,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Start Interview'),
            ),
          ],
        ),
      ),
    );
  }
}
