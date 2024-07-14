import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:srkr/UnderConstruction.dart';
import 'package:srkr/nav_components.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:srkr/pages/attendance.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
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
    User? user = FirebaseAuth.instance.currentUser;

    // Get the user's email
    String loggedInEmail = user?.email ?? "";
    Future<Map<String, dynamic>> getUserData(String email) async {
      try {
        DatabaseReference reference = FirebaseDatabase.instance.reference();

        // Use 'Students' as the reference, assuming it is the root for student data
        DatabaseEvent event = await reference
            .child('1JdinPdjMqu2yNJRN7awxsAefVWvok5qTLw7LShqQKu0')
            .child('Students')
            .orderByChild('email')
            .equalTo(email)
            .once();

        DataSnapshot dataSnapshot = event.snapshot;
        print("--" + email + "--"); // Use 'email' instead of 'loggedInEmail'
        if (dataSnapshot.value != null) {
          // Assuming there is only one record with the given email
          final userData = dataSnapshot.value as Map<dynamic, dynamic>?;

          if (userData != null && userData.isNotEmpty) {
            // Assuming there is only one record with the given email
            final userRecord = userData.values.first;

            // Extract specific fields from the user data
            // Extract specific fields from the user data
            final name = userRecord['name'] ?? 'No Data Found';
            final redgno = userRecord['redgno'] ?? 'No Data Found';
            final year = (userRecord['year'] ?? 'No Data Found')
                .toString(); // Convert to String
            final section = (userRecord['section'] ?? 'No Data Found')
                .toString(); // Convert to String
            final branch = (userRecord['branch'] ?? 'No Data Found')
                .toString(); // Convert to String

            return {
              'name': name,
              'redgno': redgno,
              'year': year,
              'section': section,
              'branch': branch,
            };
          }
        }
        print("Error fetching user data");
        return {};
        // Return an empty map if user data is not found or is null
      } catch (error) {
        print('Error fetching user data: $error');
        return {}; // Return an empty map in case of an error
      }
    }

    final Size _chartSize = Size(150.0, 150.0);
    void onItemPressed(BuildContext context, {required int index}) {
      Navigator.pop(context);

      switch (index) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AttendanceTake()));
          break;
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnderConstructionPage()));
          break;
        case 2:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnderConstructionPage()));
          break;
        case 3:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnderConstructionPage()));
          break;
        case 4:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnderConstructionPage()));
          break;
        case 5:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnderConstructionPage()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 20,
          color: Colors.black,
          icon: const Icon(Ionicons.chevron_back),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'My Profile',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-Medium',
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(loggedInEmail), // Pass the actual email here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print(snapshot.data);
            return Center(child: Text('No user data found ${loggedInEmail}'));
          } else {
            // Use the retrieved user data here
            final userData = snapshot.data!;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 140,
                        width: double.maxFinite,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: Offset(
                                    0, 2), // Offset in the x, y direction
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 0.4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'lib/images/user1.jpg',
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          userData['name'] ?? 'No Data Found',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins-Medium',
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          userData['redgno'] ?? 'No Data Found',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              userData['year'] + "/4" ??
                                                  'No Data Found',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Poppins-Medium',
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              userData['branch'] ??
                                                  'No Data Found',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Poppins-Medium',
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              userData['section'] ??
                                                  'No Data Found',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Poppins-Medium',
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset:
                                Offset(0, 2), // Offset in the x, y direction
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UnderConstructionPage()),
                          );
                        },
                        child: Card(
                          elevation: 0.4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                AnimatedCircularChart(
                                 
                                  key: _chartKey,
                                  size: _chartSize,
                                  initialChartData: <CircularStackEntry>[
                                    CircularStackEntry(
                                      <CircularSegmentEntry>[
                                        CircularSegmentEntry(
                                          33.33,
                                          Colors.blueGrey[600],
                                          rankKey: 'present',
                                        ),
                                        CircularSegmentEntry(
                                          66.67,
                                          Colors.blue[400],
                                          rankKey: 'absent',
                                        ),
                                      ],
                                      rankKey: 'progress',
                                    ),
                                  ],
                                  chartType: CircularChartType.Radial,
                                  percentageValues: true,
                                  holeLabel: '66.67',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Attendance',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Poppins-Medium',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,
                                          width: 12,
                                          color: Colors.blue[400],
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Present: 66.67',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Medium',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,
                                          width: 12,
                                          color: Colors.blueGrey[600],
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Absent: 33.33',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Medium',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Academics Marks',
                            icon: Icons.assignment,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 0),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Teacher Remarks',
                            icon: Icons.rate_review,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 0),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Certification',
                            icon: Icons.card_membership,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 0),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'About Us',
                            icon: Icons.info,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 0),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Sign Out',
                            icon: Icons.exit_to_app,
                            textColor: Colors.black,
                            onPressed: () =>
                                _handleLogout(), // Call _handleLogout when Log out is pressed
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
