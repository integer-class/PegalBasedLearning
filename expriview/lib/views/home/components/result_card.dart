// import 'package:flutter/material.dart';
// import '../../../models/interviewee.dart';

// class SecondaryIntervieweeCard extends StatelessWidget {
//   const SecondaryIntervieweeCard({
//     super.key,
//     required this.interviewee,
//   });

//   final Interviewee interviewee;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(
//             interviewee.gender == 'male' ? Icons.male : Icons.female,
//             color: interviewee.gender == 'male' ? Colors.blue : Colors.pink,
//             size: 24,
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 interviewee.name,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 interviewee.email,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../models/result.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.result,
  });

  final Result result;

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
