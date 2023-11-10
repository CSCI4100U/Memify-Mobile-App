import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          title: const Text('Go back',
              style: TextStyle(fontWeight: FontWeight.bold)),
          titleSpacing: -5,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.chevron_left))),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text('Welcome Aboard',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 60),
            const Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Email',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 375,
              height: 60,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  bottomLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(175, 255, 255, 255)),
                    contentPadding: EdgeInsets.only(left: 22, top: 10)),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Password',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 375,
              height: 60,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  bottomLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(175, 255, 255, 255)),
                    contentPadding: EdgeInsets.only(left: 22, top: 10)),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Retype Password',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 375,
              height: 60,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  bottomLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Re-enter your password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(175, 255, 255, 255)),
                    contentPadding: EdgeInsets.only(left: 22, top: 10)),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 75),
            Container(
              width: 380,
              height: 75,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 125, 14),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                    bottomLeft: Radius.circular(100.0),
                    topRight: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  )),
              child: const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Color.fromARGB(255, 22, 22, 22),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
