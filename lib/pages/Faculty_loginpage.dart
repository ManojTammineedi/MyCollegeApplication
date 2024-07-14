// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:srkr/login_components/my_button.dart';
// import 'package:srkr/login_components/my_textfield.dart';
// import 'package:srkr/pages/FacultyProfile.dart';
// import 'package:srkr/pages/forgot_password.dart';

// class FacultyLoginPage extends StatefulWidget {
//   const FacultyLoginPage({super.key});

//   @override
//   State<FacultyLoginPage> createState() => _FacultyLoginPageState();
// }

// class _FacultyLoginPageState extends State<FacultyLoginPage> {
//   // text editing controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   // sign user in method
//   void signUserIn() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Lottie.asset('lib/images/loading_animation.json'),
//               // Text(
//               //   'Please wait...',
//               //   style: TextStyle(fontSize: 18, color: Colors.black),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//     String inputId = _idController.text;
//     String inputPassword = _passwordController.text;
//     print("Input ID: $inputId");
//     print("Input Password: $inputPassword");

//     try {
//       DatabaseReference reference = FirebaseDatabase.instance.reference();

//       DatabaseEvent event = await reference
//           .child('1eR_AQCaIdNlbWN_PCLgUlrEDq-X31JvNvClg_n7SUV0')
//           .child('Facultyinfo')
//           .once();

//       DataSnapshot snapshot = event.snapshot;

//       print("Retrieved Data: ${snapshot.value}");

//       if (snapshot.value != null &&
//           snapshot.value is List<dynamic> &&
//           (snapshot.value as List<dynamic>).length > 1) {
//         List<dynamic> userData = (snapshot.value as List<dynamic>).sublist(1);

//         for (Map<dynamic, dynamic> userEntry in userData) {
//           String storedId = userEntry['id'].toString();
//           String storedPassword = userEntry['password'].toString();
//           String storedDepartment = userEntry['department'].toString();
//           String storedInvigilation_department =
//               userEntry['invigilation_place'].toString(); // Add this line
//           String storedInvigilation_dno =
//               userEntry['invigilation_dno'].toString(); // Add this line
//           String storedInvigilation_date =
//               userEntry['invigilation_date'].toString(); // Add this line

//           print("Stored ID: $storedId");
//           print("Stored Password: $storedPassword");

//           if (storedId == inputId && storedPassword == inputPassword) {
//             print("Credentials Matched!");
//             Navigator.pop(context);
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FacultyProfile(
                
//                 ),
//               ),
//             );

//             return;
//           }
//         }
//         Navigator.pop(context);
//         print("No Match Found");
//         showErrorMessage("Invalid credentials");
//       } else if (inputId.isEmpty || inputPassword.isEmpty) {
//         Navigator.pop(context);
//         showErrorMessage("Please fill in both email and password fields.");
//       } else {
//         Navigator.pop(context);
//         print("User data not found or is empty");

//         showErrorMessage("User data not found or is empty");
//       }
//     } catch (error) {
//       Navigator.pop(context);
//       print('Error: $error');

//       showErrorMessage("An error occurred. Please try again.");
//     }
//   }

//   //try sign in

//   //error message to user
//   //method 2
//   void showErrorMessage(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.red,
//           title: Center(
//             child: Text(
//               message,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       // decoration: BoxDecoration(
//       //   gradient: LinearGradient(colors: [
//       //     Color.fromARGB(255, 0, 116, 166),
//       //     Color.fromARGB(255, 0, 160, 176),
//       //     Color.fromARGB(255, 0, 197, 176),
//       //     Color.fromARGB(255, 87, 209, 197)
//       //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//       // ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 50),

//                   // logo
//                   // const Icon(
//                   //   Icons.lock,
//                   //   size: 100,
//                   // ),
//                   // ignore: prefer_const_constructors
//                   Image.asset('lib/images/logo.png'),

//                   const SizedBox(height: 50),

//                   // welcome back, you've been missed!
//                   Text(
//                     'Welcome back you\'ve been missed!',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 171, 168, 168),
//                       fontSize: 16,
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // email textfield
//                   MyTextField(
//                     controller: _idController,
//                     hintText: 'Enter ID',
//                     obscureText: false,
//                   ),

//                   const SizedBox(height: 10),

//                   // password textfield
//                   MyTextField(
//                     controller: _passwordController,
//                     hintText: 'Password',
//                     obscureText: true,
//                   ),

//                   const SizedBox(height: 10),

//                   // forgot password?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return ForgotPasswordPage();
//                                 },
//                               ),
//                             );
//                           },
//                           child: Text(
//                             'Forgot Password?',
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 171, 168, 168)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // sign in button
//                   MyButton(
//                       text: "Sign In", onTap: signUserIn, color: Colors.black),

//                   const SizedBox(height: 50),

//                   // or continue with
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }
