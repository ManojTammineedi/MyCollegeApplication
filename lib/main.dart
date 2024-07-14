import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:srkr/firebase_options.dart';
import 'package:srkr/home_page.dart';
import 'package:srkr/notification/firebase_api.dart';
import 'package:srkr/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notifications (assuming FireBaseApi().initNotifications() is correct)
  await FireBaseApi().initNotifications();

  // Run the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'auth', // Set an initial route
      routes: {
        // 'splash': (context) => SplashScreen(),
        'auth': (context) => AuthPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}
