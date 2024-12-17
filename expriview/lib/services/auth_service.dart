import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "https://fissureee.site";

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/token');

    // Create the body with x-www-form-urlencoded format
    final body = {
      'username': username,
      'password': password,
    };

    // Send the request
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['access_token']);
      return true;
    } else {
      return false;
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': username, 'email': email, 'password': password}),
      );

      // Check the API response status
      if (response.statusCode == 200) {
        // Assuming the API sends a success message
        final responseBody = jsonDecode(response.body);
        print("Registration successful: ${responseBody['message']}");
      } else {
        // Handle API error response
        final errorBody = jsonDecode(response.body);
        throw Exception("Error: ${errorBody['error']}");
      }
    } catch (e) {
      rethrow; // Pass the error up for handling in the UI
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/auth/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('token');
      } else {
        throw Exception('Failed to log out: ${response.body}');
      }
    } catch (e) {
      throw Exception('Logout error: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<Map<String, dynamic>?> userData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return null; // User is not logged in
    }

    final url = Uri.parse('$baseUrl/users/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return parsed user data
    } else {
      return null;
    }
  }

  Future<String> fetchUsername() async {
    try {
      final userDataResponse = await userData(); // Fetch user data from API

      if (userDataResponse != null && userDataResponse['username'] != null) {
        return userDataResponse['username']; // Set the username
      } else {
        return 'unknown user';
      }
    } catch (e) {
      return 'failed to fetch data';
    }
  }

  Future<void> changeEmail(String newEmail, String currentPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$baseUrl/auth/edit-email');

    final response = await http.put(
      url,
      body: json.encode({
        'new_email': newEmail,
        'password': currentPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Send the token for authentication
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update email: ${response.body}');
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final response = await http.put(
        Uri.parse('$baseUrl/auth/edit-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
            {'current_password': currentPassword, 'new_password': newPassword}),
      );

      if (response.statusCode != 200) {
        throw Exception('Error: ${response.body}');
      }
    }
  }
}
