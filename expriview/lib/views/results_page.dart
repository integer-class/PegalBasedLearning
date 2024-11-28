import 'package:expriview/views/result_detail.dart';
import 'package:flutter/material.dart'; // Ensure you import the ResultDetail class

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: ListView(
        children: const [
          PreviousSessionItem(
            name: 'Riko Saputra',
            date: 'Rabu, 15 Oktober 2025, 14:00 - 14:30',
          ),
          PreviousSessionItem(
            name: 'Maya Sari',
            date: 'Selasa, 30 September 2025, 13:00 - 13:30',
          ),
          // You can add more PreviousSessionItems here
        ],
      ),
    );
  }
}

class PreviousSessionItem extends StatelessWidget {
  final String name;
  final String date;

  const PreviousSessionItem({
    super.key,
    required this.name,
    required this.date,
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
                    const StackedBar(), // Add the stacked bar chart here
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to ResultDetail when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultDetail(
                        name: name,
                        dataMap: {
                          "Happy": 25.0, // Updated to match StackedBar
                          "Disgust": 26.0,
                          "Angry": 24.0,
                          "Fear": 11.0,
                          "Neutral": 18.0,
                          "Sad": 10.0,
                          "Surprise": 12.0,
                        }, // Updated dataMap
                        colorList: [
                          Colors.yellow, // Updated to match StackedBar
                          Colors.green,
                          Colors.red,
                          Colors.black,
                          Colors.grey,
                          Colors.blue,
                          Colors.orange,
                        ], // Updated colorList
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
  const StackedBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Width of the entire bar
      height: 10, // Height of the bar
      child: Row(
        children: [
          Flexible(
            flex: 25,
            child: Container(color: Colors.yellow),
          ),
          Flexible(
            flex: 26,
            child: Container(color: Colors.green),
          ),
          Flexible(
            flex: 24,
            child: Container(color: Colors.red),
          ),
          Flexible(
            flex: 11,
            child: Container(color: Colors.black),
          ),
          Flexible(
            flex: 18,
            child: Container(color: Colors.grey),
          ),
          Flexible(
            flex: 10,
            child: Container(color: Colors.blue),
          ),
          Flexible(
            flex: 12,
            child: Container(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
