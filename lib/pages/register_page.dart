// REGISTER PAGE: reads what the user typed and sends it to the Profile page
import 'package:flutter/material.dart';
import '../my_name.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // STEP 1. CREATE one controller for each TextField
  final nameCtrl = TextEditingController();
  final courseCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  // STEP 4. CLEAN UP the controllers when the page closes
  @override
  void dispose() {
    nameCtrl.dispose();
    courseCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  void submit() {
    // STEP 3. READ the text the user typed
    final String name = nameCtrl.text.trim();
    final String course = courseCtrl.text.trim();
    final String email = emailCtrl.text.trim();

    if (name.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields.')),
      );
      return; // stop here, do not open the Profile page
    }

    // Open the Profile page BY NAME and SEND the data with it
    Navigator.pushNamed(
      context,
      '/profile',
      arguments: {'name': name, 'course': course, 'email': email},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register - $studentName')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // STEP 2. ATTACH each controller to its TextField
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: courseCtrl,
            decoration: const InputDecoration(
              labelText: 'Course and Section (e.g. BSIT-2A)',
              prefixIcon: Icon(Icons.school),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: submit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}