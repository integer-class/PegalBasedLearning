import 'package:flutter/material.dart';
import '../../../models/interviewee.dart';

class IntervieweeCard extends StatelessWidget {
  const IntervieweeCard({
    super.key,
    required this.interviewee,
  });

  final Interviewee interviewee;

  @override
  Widget build(BuildContext context) {
    // Button style for "Start Interview" button
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.white, // Text color
      backgroundColor: const Color(0xFF2E77AE), // Background color
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 10, // Blur radius
            offset: const Offset(0, 6), // Shadow offset (x, y)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center children horizontally
        crossAxisAlignment: CrossAxisAlignment.center, // Center children vertically
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 5), // Spacing between icon and text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          interviewee.gender == 'male' ? Icons.male : Icons.female, // Gender icon
                          color: interviewee.gender == 'male'
                              ? Colors.blue
                              : Colors.pink, // Color based on gender
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          interviewee.name, // Display interviewee's name
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: const Color.fromARGB(255, 29, 3, 74),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      interviewee.email, // Display interviewee's email
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        // Blank for now, you can add logic later
                      },
                      child: const Text(
                        'Start Interview',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}