// lib/user_list_service.dart

import 'package:flutter/material.dart';
import 'user_model.dart';
import 'user_service.dart';

class UserListService {
  final UserService _userService = UserService();

  Future<void> fetchUsers(ValueNotifier<List<User>> usersNotifier, Function(String) onError) async {
    try {
      final users = await _userService.fetchUsers();
      usersNotifier.value = users; // Update the notifier with new users
    } catch (e) {
      // Call the error handler passed as a callback
      onError('Failed to load users: $e');
    }
  }
}
