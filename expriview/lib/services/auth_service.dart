import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // final String baseUrl = "https://fissureee.site";

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/token');
    final body = {
      'username': username,
      'password': password,
    };

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

  // Future<void> register(String username, String email, String password) async {
  //   try {
  //     final url = Uri.parse('$baseUrl/auth/register');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(
  //           {'username': username, 'email': email, 'password': password}),
  //     );

  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       print("Registration successful: ${responseBody['message']}");
  //     } else {
  //       final errorBody = jsonDecode(response.body);
  //       throw Exception("Error: ${errorBody['error']}");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // if (token == null) {
    //   throw Exception('No token found');
    // }

    final url = Uri.parse('$baseUrl/auth/logout');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await prefs.remove('token');
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
      return null; 
    }

    final url = Uri.parse('$baseUrl/users/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); 
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

  Future<String> fetchEmail() async {
    try {
      final userDataResponse = await userData(); 

      if (userDataResponse != null && userDataResponse['email'] != null) {
        return userDataResponse['email']; 
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

    final url = Uri.parse('$baseUrl/auth/edit-email?new_email=$newEmail&password=$currentPassword');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['detail'] ?? 'Unknown error';
        throw Exception('Failed to update email: $errorMessage');
      }
    } catch (e) {
      throw Exception('Failed to update email: ${e.toString()}');
    }
  }

  // Future<void> changePassword(
  //     String currentPassword, String newPassword) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');

  //   if (token != null) {
  //     final response = await http.put(
  //       Uri.parse('$baseUrl/auth/edit-password'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(
  //           {'current_password': currentPassword, 'new_password': newPassword}),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception('Error: ${response.body}');
  //     }
  //   }
  // }


  Future<void> changePassword(String currentPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final url = Uri.parse('$baseUrl/auth/edit-password?current_password=$currentPassword&new_password=$newPassword');

      try {
        final response = await http.put(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          return;
        } else {
          final responseData = json.decode(response.body);
          final errorMessage = responseData['detail'] ?? 'Unknown error';
          throw Exception('Failed to update password: $errorMessage');
        }
      } catch (e) {
        throw Exception('Failed to update password: ${e.toString()}');
      }
    } else {
      throw Exception('Token is missing');
    }
  }

}
