// HOME PAGE: the main menu of Student Connect
import 'package:flutter/material.dart';
import '../../my_name.dart';
import 'about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home - $studentName')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.indigo),
            const SizedBox(height: 12),
            const Text(
              'Welcome to Student Connect!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // ACTIVITY 1: open a page WITHOUT a name (push)
            FilledButton.icon(
              icon: const Icon(Icons.info),
              label: const Text('About'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            const SizedBox(height: 12),

            // ACTIVITY 2: open a page BY NAME (uncomment the 5 lines below)
             FilledButton.icon(
               icon: const Icon(Icons.person_add),
               label: const Text('Register'),
               onPressed: () => Navigator.pushNamed(context, '/register'),
             ),
            const SizedBox(height: 12),

            // ACTIVITY 3: open the live chat (uncomment the 5 lines below)
             FilledButton.icon(
               icon: const Icon(Icons.chat),
               label: const Text('Live Chat'),
               onPressed: () => Navigator.pushNamed(context, '/chat'),
             ),
          ],
        ),
      ),
    );
  }
}