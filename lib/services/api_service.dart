import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://arcanumweb-production.up.railway.app/api';
      /* 'http://127.0.0.1:8000/api'; */ //only use this link if the online site doesnt work

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed: ${json.decode(response.body)['message']}');
    }
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Registration failed: ${json.decode(response.body)['message']}',
      );
    }
  }

  static Future<void> updateProfile(
    String? name,
    String? email,
    String? token,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': name, 'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}
