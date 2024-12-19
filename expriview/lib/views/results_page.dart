import 'package:expriview/views/result_detail.dart';
import 'package:flutter/material.dart';
import 'package:expriview/services/api_service.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>>? results; // To store fetched results
  String sortBy = 'name'; // Default sorting criteria

  @override
  void initState() {
    super.initState();
    fetchAndSortResults();
  }

  void fetchAndSortResults() async {
    final fetchedResults = await apiService.fetchResults();
    setState(() {
      results = sortResults(fetchedResults, sortBy);
    });
  }

  // Sorting logic
  List<Map<String, dynamic>> sortResults(List<Map<String, dynamic>> data, String criteria) {
    data.sort((a, b) {
      switch (criteria) {
        case 'name':
          return (a['name'] ?? '').compareTo(b['name'] ?? '');
        case 'date':
          return (a['date'] ?? '').compareTo(b['date'] ?? '');
        default:
          return (b[criteria] ?? 0).compareTo(a[criteria] ?? 0);
      }
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        actions: [
          DropdownButton<String>(
            value: sortBy,
            items: const [
              DropdownMenuItem(value: 'name', child: Text('Sort by Name')),
              DropdownMenuItem(value: 'date', child: Text('Sort by Date')),
              DropdownMenuItem(value: 'happy', child: Text('Sort by Happy')),
              DropdownMenuItem(value: 'disgust', child: Text('Sort by Disgust')),
              DropdownMenuItem(value: 'angry', child: Text('Sort by Angry')),
              DropdownMenuItem(value: 'fear', child: Text('Sort by Fear')),
              DropdownMenuItem(value: 'neutral', child: Text('Sort by Neutral')),
              DropdownMenuItem(value: 'sad', child: Text('Sort by Sad')),
              DropdownMenuItem(value: 'surprise', child: Text('Sort by Surprise')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  sortBy = value;
                  results = sortResults(results!, sortBy);
                });
              }
            },
          ),
        ],
      ),
      body: results == null
          ? const Center(child: CircularProgressIndicator())
          : results!.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView.builder(
                  itemCount: results!.length,
                  itemBuilder: (context, index) {
                    final result = results![index];
                    return PreviousSessionItem(
                      name: result['name'] ?? 'Unknown',
                      date: result['date'] ?? 'No date',
                      emotionValues: {
                        "Happy": (result['happy'] ?? 0).toDouble(),
                        "Disgust": (result['disgust'] ?? 0).toDouble(),
                        "Angry": (result['angry'] ?? 0).toDouble(),
                        "Fear": (result['fear'] ?? 0).toDouble(),
                        "Neutral": (result['neutral'] ?? 0).toDouble(),
                        "Sad": (result['sad'] ?? 0).toDouble(),
                        "Surprise": (result['surprise'] ?? 0).toDouble(),
                      },
                    );
                  },
                ),
    );
  }
}

class PreviousSessionItem extends StatelessWidget {
  final String name;
  final String date;
  final Map<String, double> emotionValues;

  const PreviousSessionItem({
    super.key,
    required this.name,
    required this.date,
    required this.emotionValues,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(date),
                    const SizedBox(height: 8.0),
                    StackedBar(emotionValues: emotionValues),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultDetail(
                        name: name,
                        dataMap: emotionValues,
                        colorList: const [
                          Colors.yellow,
                          Colors.green,
                          Colors.red,
                          Colors.black,
                          Colors.grey,
                          Colors.blue,
                          Colors.orange,
                        ],
                      ),
                    ),
                  );
                },
                child: const Text('Detail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StackedBar extends StatelessWidget {
  final Map<String, double> emotionValues;

  const StackedBar({
    super.key,
    required this.emotionValues,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 10,
      child: Row(
        children: [
          Flexible(
            flex: emotionValues["Happy"]!.toInt(),
            child: Container(color: Colors.yellow),
          ),
          Flexible(
            flex: emotionValues["Disgust"]!.toInt(),
            child: Container(color: Colors.green),
          ),
          Flexible(
            flex: emotionValues["Angry"]!.toInt(),
            child: Container(color: Colors.red),
          ),
          Flexible(
            flex: emotionValues["Fear"]!.toInt(),
            child: Container(color: Colors.black),
          ),
          Flexible(
            flex: emotionValues["Neutral"]!.toInt(),
            child: Container(color: Colors.grey),
          ),
          Flexible(
            flex: emotionValues["Sad"]!.toInt(),
            child: Container(color: Colors.blue),
          ),
          Flexible(
            flex: emotionValues["Surprise"]!.toInt(),
            child: Container(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
