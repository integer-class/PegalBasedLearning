import 'package:flutter/material.dart';

import '../../../models/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.isMale, // Tambahkan properti untuk gender
  });

  final Course course;
  final bool isMale; // true untuk male, false untuk female

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
            color: Colors.black.withOpacity(0.1), // Warna bayangan
            blurRadius: 10, // Blur radius
            offset: const Offset(0, 6), // Posisi bayangan (x, y)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Align children to the center
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align vertically to the center
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 5), // Spasi antara ikon dan teks
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center items in Column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isMale ? Icons.male : Icons.female, // Gender icon
                          color: isMale
                              ? Colors.blue
                              : Colors.pink, // Warna sesuai gender
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          course.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: const Color.fromARGB(255, 29, 3, 74),
                                  fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Text(
                      "Tanggal Interview: 14 June 2020",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const Text(
                      "Pukul: 13.00",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        // Button pressed logic
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
