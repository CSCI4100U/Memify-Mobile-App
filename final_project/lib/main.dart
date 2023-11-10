import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/main': (context) => const Main()
      },
    );
  }
}
