import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srkr/pages/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 4 seconds (4000 milliseconds)
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AuthPage();
          },
        ),
      );
      ; // Go back to the previous page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // decoration: const BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [Colors.white],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Welcome to SRKR',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Center(child: Image.asset('lib/images/logo4.png')),
                SizedBox(height: 20),
                Text(
                  'Let We Be Your Path!',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: 'Bold-Poppins'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
