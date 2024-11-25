import 'package:expriview/views/result_detail.dart';
import 'package:flutter/material.dart'; // Ensure you import the ResultDetail class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Results Page Example',
      home: const ResultsPage(),
    );
  }
}

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: ListView(
        children: [
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
    Key? key,
    required this.name,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Margin for the item
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
                          "Segment A": 40,
                          "Segment B": 30,
                          "Segment C": 30,
                        }, // Example dataMap
                        colorList: [
                          Colors.blue,
                          Colors.red,
                          Colors.green,
                        ], // Example colorList
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
  const StackedBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Width of the entire bar
      height: 30, // Height of the bar
      child: Row(
        children: [
          Flexible(
            flex: 27,
            child: Container(color: Colors.yellow),
          ),
          Flexible(
            flex: 28,
            child: Container(color: Colors.purple),
          ),
          Flexible(
            flex: 26,
            child: Container(color: Colors.red),
          ),
          Flexible(
            flex: 11,
            child: Container(color: Colors.pink),
          ),
          Flexible(
            flex: 20,
            child: Container(color: Colors.orange),
          ),
          Flexible(
            flex: 10,
            child: Container(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}