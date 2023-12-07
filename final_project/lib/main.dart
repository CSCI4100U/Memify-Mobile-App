import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'firebase/firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/main_page.dart';
import 'database/settings_db.dart';
import 'Firebase/auth.dart';
import 'firebase/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // if user does not have notifications disabled setting then initialize notifiications
  if (await SettingsDB().isNotificationsDisabled(Auth().currentUser!.email) !=
      1) {
    await Noti().initNotifications();
  }
  // Lock the device orientation to portrait up and down before the app starts
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> hasAccount() async {
    try {
      User? user = Auth().currentUser;
      if (await SettingsDB().isAutoLoginDisabled(user!.email!) == true) {
        return false;
      }

      return true;
        } catch (e) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasAccount(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator or placeholder while waiting for the result.
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.data!) {
          // Handle errors or when hasAccount returns false.
          return MaterialApp(
            home: const Home(),
            routes: <String, WidgetBuilder>{
              '/home': (context) => const Home(),
              '/login': (context) => const Login(),
              '/signup': (context) => const Signup(),
              '/main': (context) => const Main(),
            },
          );
        } else {
          // User has an account, navigate to the Main screen.
          return MaterialApp(
            home: const Main(),
            routes: <String, WidgetBuilder>{
              '/home': (context) => const Home(),
              '/login': (context) => const Login(),
              '/signup': (context) => const Signup(),
              '/main': (context) => const Main(),
            },
          );
        }
      },
    );
  }
}
