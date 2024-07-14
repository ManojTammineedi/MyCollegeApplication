import 'package:flutter/material.dart';
import 'package:srkr/UnderConstruction.dart';
import 'package:srkr/cse.dart';
import 'package:srkr/cse_department.dart';
import 'package:srkr/home_page.dart';
import 'package:srkr/menu.dart';
import 'package:srkr/news.dart';
import 'package:url_launcher/url_launcher.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _currentIndex = 2;
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Bold-Poppins',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            children: [
              buildGridItem(Icons.build, const Color.fromARGB(255, 55, 55, 55),
                  "MECH", UnderConstructionPage()),
              buildGridItem(Icons.computer_sharp,
                  const Color.fromARGB(255, 55, 55, 55), "CSE", CSE()),
              buildGridItem(
                  Icons.perm_device_information_outlined,
                  const Color.fromARGB(255, 55, 55, 55),
                  "IT",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.signal_cellular_alt,
                  const Color.fromARGB(255, 55, 55, 55),
                  "ECE",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.electrical_services,
                  const Color.fromARGB(255, 55, 55, 55),
                  "EEE",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.engineering_outlined,
                  const Color.fromARGB(255, 55, 55, 55),
                  "CIVIL",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.business_center_outlined,
                  const Color.fromARGB(255, 55, 55, 55),
                  "CSBS",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.dataset,
                  const Color.fromARGB(255, 55, 55, 55),
                  "AIML",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.design_services,
                  const Color.fromARGB(255, 55, 55, 55),
                  "CSD",
                  UnderConstructionPage()),
              buildGridItem(
                  Icons.graphic_eq_rounded,
                  const Color.fromARGB(255, 55, 55, 55),
                  "CSG",
                  UnderConstructionPage()),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          ),
        ),
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
            Navigator.pushReplacement(
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

  Widget buildGridItem(IconData icon, Color color, String text, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
