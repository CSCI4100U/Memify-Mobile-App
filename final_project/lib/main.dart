import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup()
      },
    );
  }
}
