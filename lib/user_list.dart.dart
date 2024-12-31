import 'package:flutter/material.dart';
import 'user_model.dart';
import 'user_list_service.dart';
import 'user_delete_dialog.dart'; // Import the new dialog

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  UserListState createState() => UserListState();
}

class UserListState extends State<UserList> {
  final ValueNotifier<List<User>> _usersNotifier = ValueNotifier<List<User>>([]);
  final UserListService _userListService = UserListService();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    await _userListService.fetchUsers(_usersNotifier, (errorMessage) {
      // Show Snackbar if there's an error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    });
  }

  void _deleteUser(int index) {
    final user = _usersNotifier.value[index];
    
    showDialog(
      context: context,
      builder: (context) {
        return UserDeleteDialog(
          user: user,
          onDelete: () {
            setState(() {
              _usersNotifier.value.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${user.firstName} has been deleted.')),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchUsers,
        child: ValueListenableBuilder<List<User>>(
          valueListenable: _usersNotifier,
          builder: (context, users, _) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300], // Set a background color
                      radius: 25,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white, // Icon color
                      ),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user.email),
                    onTap: () => _deleteUser(index), // Delete user on tap
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
