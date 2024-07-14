// ignore: camel_case_types
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:srkr/UnderConstruction.dart';
import 'package:srkr/home_page.dart';
import 'package:srkr/nav_components.dart';
import 'package:srkr/pages/FacultyProfile.dart';
import 'package:srkr/pages/Faculty_loginpage.dart';
import 'package:srkr/pages/about_srkr.dart';
import 'package:srkr/pages/academics.dart';
import 'package:srkr/place.dart';
import 'package:srkr/placements_page.dart';

class iNavigationDrawer extends StatefulWidget {
  const iNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<iNavigationDrawer> createState() => _iNavigationDrawerState();
}

class _iNavigationDrawerState extends State<iNavigationDrawer> {
  bool showProgressIndicator = false;

  Future<void> _handleLogout() async {
    await signUserOut();
    Navigator.pop(context); // Close the drawer
  }

  Future<void> signUserOut() async {
    setState(() {
      showProgressIndicator = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Introduce a 2-second delay

    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Sign out error: $e");
    } finally {
      setState(() {
        showProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Drawer(
        backgroundColor: Colors.white.withOpacity(0.3),
        child: Material(
          color: Colors.white.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
            child: Column(
              children: [
                headerWidget(),
                // const SizedBox(
                //   height: 30,q
                // ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                  name: 'Home',
                  icon: Icons.home,
                  textColor: Colors.white,
                  onPressed: () => onItemPressed(context, index: 0),
                ),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    name: 'About SRKR',
                    icon: Icons.info,
                    textColor: Colors.white,
                    onPressed: () => onItemPressed(context, index: 1)),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    name: 'Academics',
                    icon: Icons.school,
                    textColor: Colors.white,
                    onPressed: () => onItemPressed(context, index: 2)),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    name: 'Placements',
                    icon: Icons.work,
                    textColor: Colors.white,
                    onPressed: () => onItemPressed(context, index: 3)),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    name: 'Feedback',
                    icon: Icons.feedback,
                    textColor: Colors.white,
                    onPressed: () => onItemPressed(context, index: 4)),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    name: 'Student Zone',
                    icon: Icons.emoji_people,
                    textColor: Colors.white,
                    onPressed: () => onItemPressed(context, index: 5)),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    name: 'Facutly Zone',
                    icon: Icons.group,
                    textColor: Colors.white,
                    onPressed: () => onItemPressed(context, index: 6)),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.white,
                ),

                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  textColor: Colors.white,
                  onPressed: () =>
                      _handleLogout(), // Call _handleLogout when Log out is pressed
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutSrkr()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Academics()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Placements()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UnderConstructionPage()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UnderConstructionPage()));
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FacultyProfile()));
        break;
      case 7:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UnderConstructionPage()));
        break;
    }
  }

  Widget headerWidget() {
    // Move the user retrieval code inside the build method
    User? user = FirebaseAuth.instance.currentUser;

    // Get the user's email
    String loggedInEmail = user?.email ?? "No email";
    return Column(
      children: [
        Center(
          child: Row(
            children: [
              Container(
                width: 40, // Adjust the width as needed
                height: 40, // Adjust the height as needed
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: AssetImage(
                      'lib/images/user.png',
                    ),
                    fit: BoxFit.contain, // Adjust the fit property as needed
                  ),
                  // To make it a circular container
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text('USER',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 51, 50, 50),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    loggedInEmail,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins-Regular',
                      color: Color.fromARGB(255, 51, 50, 50),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
