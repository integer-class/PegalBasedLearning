import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Interviewee {
  final int id;
  final String name;
  final String gender;
  final String email;
  final String? cv;
  final String createdAt;
  final String updatedAt;

  Interviewee({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    this.cv,
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ApiService {
  static const String baseUrl = 'https://fissureee.site';

  Future<List<Interviewee>> getInterviewees() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/interviewees'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> intervieweesJson = data['data'];
        return intervieweesJson.map((json) => Interviewee.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load interviewees: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching interviewees: $e');
      throw e;
    }
  }


  Future<EmotionResponse> analyzeEmotion(dynamic imageData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      
      var uri = Uri.parse('$baseUrl/analyze-emotion');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      if (imageData is Uint8List) {
        // Handle web case (bytes)
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            imageData,
            filename: 'image.jpg',
          ),
        );
      } else if (imageData is String) {
        // Handle mobile case (file path)
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            imageData,
            filename: 'image.jpg',
          ),
        );
      } else {
        throw ArgumentError('imageData must be either Uint8List or String');
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return EmotionResponse.fromJson(data);
      } else {
        throw Exception('Failed to analyze emotion: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in analyzeEmotion: $e');
      throw e;
    }
  }


  Future<void> startSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.post(
        
        Uri.parse('$baseUrl/start-session'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        final data = json.decode(response.body);
        throw Exception(data['message'] ?? 'Failed to start session');
      }
    } catch (e) {
      print('Error starting session: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>> endSession(int intervieweeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/end-session/$intervieweeId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return data['emotion_counts'];
        } else {
          throw Exception(data['message'] ?? 'Failed to end session');
        }
      } else {
        throw Exception('Failed to end session');
      }
    } catch (e) {
      print('Error ending session: $e');
      throw e;
    }
  }


  Future<List<Map<String, dynamic>>> fetchResults() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/results'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to load results: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching results: $e');
      throw e;
    }
  }
}

class EmotionResponse {
  final String emotion;
  final double confidence;
  final Map<String, int>? sessionCounts;

  EmotionResponse({
    required this.emotion,
    required this.confidence,
    this.sessionCounts,
  });

  factory EmotionResponse.fromJson(Map<String, dynamic> json) {
    return EmotionResponse(
      emotion: json['emotion'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      sessionCounts: json['current_session_counts'] != null 
          ? Map<String, int>.from(json['current_session_counts'])
          : null,
    );
  }
}
