import 'package:flutter/material.dart';

import '../../../models/interviewee.dart';
import '../../recording_page.dart';

class IntervieweeCard extends StatelessWidget {
  const IntervieweeCard({
    super.key,
    required this.interviewee,
  });

  final Interviewee interviewee;

  @override
  Widget build(BuildContext context) {
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          interviewee.gender == 'male'
                              ? Icons.male
                              : Icons.female,
                          color: interviewee.gender == 'male'
                              ? Colors.blue
                              : Colors.pink,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          interviewee.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: const Color.fromARGB(255, 29, 3, 74),
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      interviewee.email,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RecordingPage(
                              intervieweeId: interviewee.id,
                              intervieweeName: interviewee.name,
                            ),
                          ),
                        );
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
