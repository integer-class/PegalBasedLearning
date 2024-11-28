import 'package:http/http.dart' as http;
import 'dart:convert';

class Interviewee {
  final int id;
  final String name;
  final String gender;
  final String email;
  final String? cv;
  final String status;
  final String createdAt;
  final String updatedAt;

  Interviewee({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    this.cv,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Interviewee.fromJson(Map<String, dynamic> json) {
    return Interviewee(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      email: json['email'],
      cv: json['cv'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  Future<List<Interviewee>> getInterviewees() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/interviewees'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> intervieweesJson = data['data'];
        return intervieweesJson.map((json) => Interviewee.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load interviewees');
      }
    } catch (e) {
      print('Connection Error: $e');
      throw e;
    }
  }
}
