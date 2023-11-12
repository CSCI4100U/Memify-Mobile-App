import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/main_page.dart';
import 'database/login_db.dart';
import 'Firebase/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Lock the device orientation to portrait up and down before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> hasAccount() async {
    Map<String, String> emailAndPassword = await LoginDB().fetchAccount();

    String email = emailAndPassword['email'] ?? '';
    String password = emailAndPassword['password'] ?? '';

    if (email == '' || password == '') {
      return false;
    } else {
      try {
        await Auth()
            .logInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException {
        return false;
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: hasAccount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the Future is still resolving, show a loading indicator or another widget
            return Container(
              // loading screen
              color: Colors.black,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 230, 125, 14))),
            );
          } else if (snapshot.hasError) {
            return const Home();
          } else {
            // if null then always false
            final bool isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? const Main() : const Home();
          }
        },
      ),
      routes: <String, WidgetBuilder>{
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/main': (context) => const Main()
      },
    );
  }
}
