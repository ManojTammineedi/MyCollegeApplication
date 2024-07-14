import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:srkr/login_components/my_button.dart';
import 'package:srkr/login_components/my_textfield.dart';
import 'package:srkr/login_components/square_tile.dart';
import 'package:srkr/pages/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailPattern = RegExp(
    r'^[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}([0-9]{4}|[0-9]{2}[A-Z]{1}[0-9]{1,2})@srkrec\.ac\.in$');
//   final emailPattern2 = RegExp(
//       r'^[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{1,2}@srkrec\.ac\.in$');
// //                            //21B91A05U8
  // sign user up method
  void signUserUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    
    // Check if password and confirmPassword match
    if (password != confirmPassword) {
      showErrorMessage("Passwords don't match");
      return; // Exit the function early
    }
    print(emailController);
    if (!emailPattern.hasMatch(email)) {
      showErrorMessage("Please Login With College Provided Email");
      return; // Exit the function early
    }
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('lib/images/loading_animation.json'),
              Text(
                'Please wait...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseFirestore.instance
          .collection('student')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      // Pop the loading circle on success
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle on error
      Navigator.pop(context);

      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        showErrorMessage("Please fill the fields");
      } else {
        showErrorMessage(e.code.replaceAll('-', ' '));
      }
    }
  }

  //error message to user
  //method 2
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
  //wrong email message popup
  // void wrongEmailMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text('Incorrect Email'),
  //       );
  //     },
  //   );
  // }

  // void wrongPasswordMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text('Incorrect Password'),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(colors: [
      //     Color.fromARGB(255, 0, 116, 166),
      //     Color.fromARGB(255, 0, 160, 176),
      //     Color.fromARGB(255, 0, 197, 176),
      //     Color.fromARGB(255, 87, 209, 197)
      //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  // ),
                  // ignore: prefer_const_constructors
                  Image.asset('lib/images/logo.png'),

                  const SizedBox(height: 50),

                  //Let\'s create an account for you!
                  Text(
                    'Let\'s create an account for you!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 171, 168, 168),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  // forgot password?

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                      text: 'Sign Up', onTap: signUserUp, color: Colors.black),

                  const SizedBox(height: 25),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromARGB(255, 171, 168, 168),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                                color: Color.fromARGB(255, 171, 168, 168)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromARGB(255, 171, 168, 168),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(
                          onTap: () => AuthService().signInWithGoogle(),
                          imagePath: 'lib/images/google.png'),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
