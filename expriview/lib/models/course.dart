import 'package:flutter/material.dart';

class Course {
  final String title, description;
  final Color bgColor;

  Course({
    required this.title,
    this.description = "Build and animate an iOS app from scratch",
    // this.iconSrc = "assets/icons/ios.svg",
    this.bgColor = const Color(0xFF7553F6),
  });
}

List<Course> courses = [
  Course(title: "Riko Saputra"),
  Course(title: "Maya Sari"),
  Course(title: "Adi Wirawan"),
];

// We need it later
List<Course> recentCourses = [
  Course(title: "Riko Saputra"),
  Course(
    title: "Maya Sari",
    bgColor: const Color(0xFF9CC5FF),
  ),
];
