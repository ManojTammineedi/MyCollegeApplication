import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:srkr/UnderConstruction.dart';
import 'package:srkr/custom_ion.dart';
import 'package:srkr/events.dart';
import 'package:srkr/menu.dart';
import 'package:srkr/nav_bar.dart';
import 'package:srkr/news.dart';
import 'package:srkr/notes_page.dart';
import 'package:srkr/pages/student_profile.dart';
import 'package:srkr/top_stories.dart';
import 'package:srkr/view_full.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOffline = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    setState(() {
      isOffline = !isConnected;
    });
  }

  Future<void> _navigateToResultsPage() async {
    final Uri url = Uri.parse('http://www.srkrexams.in/Login.aspx');
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Get the user's email
    String loggedInEmail = user?.email ?? "No email";
    return Scaffold(
      drawer: iNavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontFamily: 'Bold-Poppins'),
            ),
            Text(
              loggedInEmail,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins-Light',
              ),
            ),
          ],
        ),
        actions: [
          // CustomIconButton(
          //   icon: Icon(Ionicons.search_outline),
          // ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: Icon(Ionicons.notifications_outline),
              onPressed: () {
                // Navigate to the notifications page when the notifications icon is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UnderConstructionPage(), // Replace with the actual widget for the notifications page
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CustomIconButton(
              icon: Icon(Ionicons.person),
              onPressed: () {
                // Navigate to the notifications page when the notifications icon is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentProfile(), // Replace with the actual widget for the notifications page
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: isOffline
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'lib/images/offline.json', // Replace with your Lottie animation file
                    // height: 200,
                    // width: 200,
                  ),
                  Text(
                    'You are offline',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // You can add any logic to handle offline state
                      // For example, show cached data or try to reconnect
                      checkConnectivity();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(
                          255, 142, 153, 162), // Change the text color
                      minimumSize:
                          Size(200, 48), // Change the button length and height
                    ),
                    child: Text('Retry'),
                  )
                ],
              ),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(14),
              children: [
                Container(
                  height: 40.0,
                  child: Marquee(
                    text:
                        "FLASH NEWS: For Latest Examination Related Notifications / Time Tables / Results: Click Here",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins-Medium',
                    ),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    pauseAfterRound: Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.1,
                    fadingEdgeEndFraction: 0.1,
                    numberOfRounds: null,
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 2),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 100),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                // LiveSafe(),
                // CATEGORIES

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Top Stories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ViewFull())),
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ))
                  ],
                ),
                // const SizedBox(height: 10),
                const RecommendedPlaces(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Events",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () => Navigator.of(context).push(
                    //         MaterialPageRoute(builder: (context) => ViewFull())),
                    //     child: const Text("View All"))
                  ],
                ),
                const SizedBox(height: 10),
                const Events(),
              ],
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation based on index
          if (index == 0) {
            // Navigate to Home
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => HomePage(),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
          } else if (index == 1) {
            // Navigate to News
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => News(),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
          } else if (index == 2) {
             Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => Notes(),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
            // Navigate to Resources
          } else if (index == 3) {
            // Navigate to Results
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  _navigateToResultsPage();
                  return Container(); // You need to return some widget here
                },
              ),
            );
          }
        },
      ),
    );
  }
}
