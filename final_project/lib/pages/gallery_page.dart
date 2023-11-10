import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        title: const Text(
          "Gallery",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 45, color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
