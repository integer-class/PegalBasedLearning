import 'package:expriview/views/result_detail.dart';
import 'package:flutter/material.dart'; // Ensure you import the ResultDetail class
import 'package:expriview/services/api_service.dart';


class ResultsPage extends StatelessWidget {
  final ApiService apiService = ApiService();
  
  ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiService.fetchResults(), // Updated to use instance method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final result = snapshot.data![index];
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
        margin: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Margin for the item
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the item
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
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
                    const SizedBox(height: 8.0), // Space before the bar chart
                    StackedBar(emotionValues: emotionValues), // Pass values to StackedBar
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
                        dataMap: emotionValues, // Use the passed values
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
