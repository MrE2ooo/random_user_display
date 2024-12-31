import 'package:flutter/material.dart';
import 'user_model.dart';

class UserDeleteDialog extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;

  const UserDeleteDialog({
    super.key,
    required this.user,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete User'),
      content: Text('Are you sure you want to delete ${user.firstName} ${user.lastName}?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDelete(); // Call the delete callback
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
