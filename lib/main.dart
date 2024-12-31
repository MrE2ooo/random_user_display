// main.dart

import 'package:flutter/material.dart';
import 'package:randomuser/user_list.dart.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Display Random users From randomuser API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserList(),
    );
  }
}
