import 'package:final_project/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../database/settings_db.dart";

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? errorMessage = '';

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerRePassword = TextEditingController();

  Future<bool> signUp() async {
    try {
      await Auth().signUpWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text);
      return true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      return false;
    }
  }

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
              child: TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(175, 255, 255, 255)),
                    contentPadding: EdgeInsets.only(left: 22, top: 10)),
                style: const TextStyle(color: Colors.white, fontSize: 20),
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
              child: TextField(
                controller: controllerPassword,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(175, 255, 255, 255)),
                    contentPadding: EdgeInsets.only(left: 22, top: 10)),
                style: const TextStyle(color: Colors.white, fontSize: 20),
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
              child: TextField(
                controller: controllerRePassword,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Re-enter your password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(175, 255, 255, 255)),
                    contentPadding: EdgeInsets.only(left: 22, top: 10)),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              // display error message to user
              errorMessage == '' ? '' : '$errorMessage',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 75),
            GestureDetector(
              onTap: () async {
                if (controllerPassword.text != controllerRePassword.text) {
                  setState(() {
                    errorMessage = 'Please make sure passwords match';
                  });
                } else if (await signUp() == true) {
                  SettingsDB().rememberSettings(
                      email: controllerEmail.text,
                      pfp:
                          "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg",
                      notifications: 0,
                      autoLogin: 0);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Signed Up Successfully!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Color.fromARGB(255, 230, 125, 14),
                  ));
                  Navigator.pop(context);
                }
              },
              child: Container(
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
            )
          ],
        ),
      ),
    );
  }
}
