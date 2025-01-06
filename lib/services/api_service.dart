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
        throw Exception('بيانات الاعتماد غير صحيحة');
      }

      // Extract user data
      final user = data['data'][0];

      // Validate password
      if (user['password'] != (password ?? "_empty")) {
        // Adjust if hashing passwords
        throw Exception('بيانات الاعتماد غير صحيحة');
      }

      return user;
    } else {
      if (kDebugMode) {
        print("فشل في استرداد المستخدم: ${response.body}");
      }
      throw Exception(
          'حدث خطأ أثناء تسجيل الدخول.\nيرجى المحاولة مرة أخرى لاحقًا.');
    }
  }
}
