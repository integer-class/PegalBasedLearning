import 'package:flutter/material.dart';
import '../../../models/result.dart';
import '../../result_detail.dart'; 

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.result,
  });

  final Result result;

  @override
  Widget build(BuildContext context) {
    
    final Map<String, double> dataMap = {
      'Happy': result.happy.toDouble(),
      'Disgust': result.disgust.toDouble(),
      'Angry': result.angry.toDouble(),
      'Fear': result.fear.toDouble(),
      'Neutral': result.neutral.toDouble(),
      'Sad': result.sad.toDouble(),
      'Surprise': result.surprise.toDouble(),
    };

    final List<Color> colorList = [
      Colors.yellow, 
      Colors.green, 
      Colors.red, 
      Colors.black, 
      Colors.grey, 
      Colors.blue, 
      Colors.orange, 
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
                Text(
                  result.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 10,
                child: Row(
                  children: [
                    Flexible(
                      flex: result.happy.toInt(),
                      child: Container(color: Colors.yellow),
                    ),
                    Flexible(
                      flex: result.disgust.toInt(),
                      child: Container(color: Colors.green),
                    ),
                    Flexible(
                      flex: result.angry.toInt(),
                      child: Container(color: Colors.red),
                    ),
                    Flexible(
                      flex: result.fear.toInt(),
                      child: Container(color: Colors.black),
                    ),
                    Flexible(
                      flex: result.neutral.toInt(),
                      child: Container(color: Colors.grey),
                    ),
                    Flexible(
                      flex: result.sad.toInt(),
                      child: Container(color: Colors.blue),
                    ),
                    Flexible(
                      flex: result.surprise.toInt(),
                      child: Container(color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF2E77AE),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultDetail(
                    name: result.name,
                    dataMap: dataMap,
                    colorList: colorList,
                  ),
                ),
              );
            },
            child: const Text(
              'Detail',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}