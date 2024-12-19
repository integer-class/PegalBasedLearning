import 'package:expriview/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import untuk SVG

import '../../models/interviewee.dart';
import '../../models/result.dart';
import 'components/interviewee_card.dart';
import 'components/result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Interviewee> interviewees = [];
  List<Result> results = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadInterviewees();
    _loadResults();
  }

  Future<void> _loadInterviewees() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final fetchedInterviewees = await _apiService.getInterviewees();
      setState(() {
        interviewees = fetchedInterviewees;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _loadResults() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final fetchedResults = await _apiService.getResults();
      setState(() {
        results = fetchedResults;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
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
                        'Welcome back! Ready to start interviewing?',
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
                    ...interviewees.map((interviewee) => Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: IntervieweeCard(
                            interviewee: interviewee,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Space between "Recent" and "See All"
                  children: [
                    const Text(
                      "Recent",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your action here when "See All" is pressed
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 460,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ...results.map(
                        (result) => Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 15),
                          child: ResultCard(result: result),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
