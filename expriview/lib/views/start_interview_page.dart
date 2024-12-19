import 'package:flutter/material.dart';
import 'recording_page.dart';
import '../services/api_service.dart';
import '../models/interviewee.dart';

class StartInterviewPage extends StatefulWidget {
  const StartInterviewPage({super.key});

  @override
  _StartInterviewPageState createState() => _StartInterviewPageState();
}
class _StartInterviewPageState extends State<StartInterviewPage> {
  final ApiService _apiService = ApiService();
  List<Interviewee> interviewees = [];
  List<Interviewee> filteredInterviewees = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadInterviewees();
  }

  Future<void> _loadInterviewees() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });
      
      final fetchedInterviewees = await _apiService.getInterviewees();
      setState(() {
        interviewees = fetchedInterviewees;
        filteredInterviewees = fetchedInterviewees;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      print('Error loading interviewees: $e');
    }
  }

  void _searchInterviewee(String query) {
    setState(() {
      filteredInterviewees = interviewees
          .where((interviewee) => 
              interviewee.name.toLowerCase().contains(query.toLowerCase()))
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
            color: const Color.fromARGB(
                255, 0, 0, 0), // Set the color of the search icon to blue
            onPressed: () {
              showSearch(
                context: context,
                delegate: IntervieweeSearchDelegate(
                  searchInterviewee: _searchInterviewee,
                  interviewees: interviewees,
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
          children:
              filteredInterviewees.map((interviewee) => SessionCard(
                id: interviewee.id,
                name: interviewee.name,
                gender: interviewee.gender,
                email: interviewee.email,
              )).toList(),
        ),
      ),
    );
  }
}

class SessionCard extends StatelessWidget {
  final int id;
  final String name;
  final String gender;
  final String email;

  const SessionCard({
    super.key,
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      gender == 'male' ? Icons.male : Icons.female,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      gender.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecordingPage(
                          intervieweeId: id,
                          intervieweeName: name,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Start Interview'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IntervieweeSearchDelegate extends SearchDelegate {
  final Function(String) searchInterviewee;
  final List<Interviewee> interviewees;

  IntervieweeSearchDelegate({
    required this.searchInterviewee,
    required this.interviewees,
  });

  @override
  String? get searchFieldLabel => 'Search Interviewees';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchInterviewee(query);
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
      children: const [
        // You can show the filtered results here, but we are handling it in the main page
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = interviewees
        .where((interviewee) =>
            interviewee.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final interviewee = suggestions[index];
        return ListTile(
          leading: Icon(
            interviewee.gender == 'male' ? Icons.male : Icons.female,
            color: Colors.grey[600],
          ),
          title: Text(interviewee.name),
          subtitle: Text(interviewee.email),
          onTap: () {
            query = interviewee.name;
            searchInterviewee(query);
            close(context, null);
          },
        );
      },
    );
  }
}
