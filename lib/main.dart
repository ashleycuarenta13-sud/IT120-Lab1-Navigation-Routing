// LAB 1: Student Connect - the app starts here
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart'; // ACTIVITY 2: uncomment
import 'pages/profile_page.dart'; // ACTIVITY 2: uncomment
import 'pages/chat_page.dart'; // ACTIVITY 3: uncomment

void main() {
  runApp(const StudentConnectApp());
}

class StudentConnectApp extends StatelessWidget {
  const StudentConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // The first page shown when the app starts
      initialRoute: '/',
      // Every page that has a NAME
      routes: {
        '/': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(), // ACTIVITY 2
        '/profile': (context) => const ProfilePage(), // ACTIVITY 2done
        '/chat': (context) => const ChatPage(), // ACTIVITY 3
      },
    );
  }
}