import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import untuk SVG

import '../../models/course.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hi, James",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 8), // Jarak antara teks dan SVG
                        SvgPicture.asset(
                          'assets/icons/hi.svg',
                          width: 28, // Ukuran SVG
                          height: 28,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Jarak antara teks
                    const Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Welcome back! Ready to ace your next interview?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...courses.map((course) => Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CourseCard(course: course),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Recent",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ...recentCourses.map(
                (course) => Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: SecondaryCourseCard(course: course),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
