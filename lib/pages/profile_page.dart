// PROFILE PAGE: receives the data sent by the Register page
import 'package:flutter/material.dart';
import '../my_name.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // RECEIVE the data that came with pushNamed(..., arguments: ...)
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String name = data['name']!;
    final String course = data['course']!;
    final String email = data['email']!;

    return Scaffold(
      appBar: AppBar(title: Text('Profile - $studentName')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              child: Text(name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 16),
            Text(
              'Hello, $name!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Course: $course', style: const TextStyle(fontSize: 18)),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Edit (Go Back)'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}