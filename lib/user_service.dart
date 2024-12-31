// lib/user_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_model.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=10&gender=male'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body)['results'];
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
