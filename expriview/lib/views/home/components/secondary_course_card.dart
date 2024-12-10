import 'package:flutter/material.dart';

import '../../../models/course.dart';

class SecondaryCourseCard extends StatelessWidget {
  const SecondaryCourseCard({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
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
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
                const Text(
                  "14 Juni 2020, 13.00 - 13.30",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
            child: VerticalDivider(
              color: Colors.grey,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 8,
                    color: Colors.blue, // Bar 1
                  ),
                  Container(
                    width: 15,
                    height: 8,
                    color: Colors.green, // Bar 2
                  ),
                  Container(
                    width: 10,
                    height: 8,
                    color: Colors.red, // Bar 3
                  ),
                ],
              ),
              const SizedBox(height: 4), // Space between the bars and the text
              const Text(
                'Happy: 40%',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
            child: VerticalDivider(
              color: Colors.grey,
            ),
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
              // Button pressed logic
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
