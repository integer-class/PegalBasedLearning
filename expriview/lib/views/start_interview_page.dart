import 'package:flutter/material.dart';
import 'recording_page.dart';

class StartInterviewPage extends StatefulWidget {
  const StartInterviewPage({super.key});

  @override
  _StartInterviewPageState createState() => _StartInterviewPageState();
}

class _StartInterviewPageState extends State<StartInterviewPage> {
  List<String> intervieweeNames = ['Riko Saputra', 'Maya Sari', 'Adi Wirawan'];
  List<String> filteredNames = [];

  @override
  void initState() {
    super.initState();
    filteredNames = intervieweeNames; // Initially, show all names
  }

  void _searchInterviewee(String query) {
    setState(() {
      filteredNames = intervieweeNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: const Color.fromARGB(255, 0, 0, 0), // Set the color of the search icon to blue
            onPressed: () {
              showSearch(
                context: context,
                delegate: IntervieweeSearchDelegate(
                  searchInterviewee: _searchInterviewee,
                ),
              );
            },
          ),
        ],
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
          children: filteredNames.map((name) => SessionCard(name: name)).toList(),
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
                backgroundColor: Colors.blue, // Set the button color to blue
                foregroundColor: Colors.white, // Set the text color to white
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

class IntervieweeSearchDelegate extends SearchDelegate {
  final Function(String) searchInterviewee;

  IntervieweeSearchDelegate({required this.searchInterviewee});

  @override
  String? get searchFieldLabel => 'Search Interviewees';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchInterviewee(query); // Reset to all names
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchInterviewee(query); // Filter the list based on the query
    return ListView(
      children: [
        // You can show the filtered results here, but we are handling it in the main page
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        // Suggestion list will show matching names dynamically as you type
        for (var name in ['Riko Saputra', 'Maya Sari', 'Adi Wirawan'])
          ListTile(
            title: Text(name),
            onTap: () {
              query = name;
              searchInterviewee(name);
              close(context, null);
            },
          ),
      ],
    );
  }
}
