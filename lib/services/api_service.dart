import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(
    String? email,
    String? password,
  ) async {
    final url = Uri.parse(
        '$baseUrl/items/Users?filter[email][_eq]=${email ?? "_empty"}');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Check if user exists
      if (data['data'].isEmpty) {
        throw Exception('Invalid credentials');
      }

      // Extract user data
      final user = data['data'][0];

      // Validate password
      if (user['password'] != (password ?? "_empty")) {
        // Adjust if hashing passwords
        throw Exception('Invalid credentials');
      }

      return user;
    } else {
      if (kDebugMode) {
        print("Failed to fetch user: ${response.body}");
      }
      throw Exception(
          'Something went wrong while logging in.\nPlease try again later.');
    }
  }
}
