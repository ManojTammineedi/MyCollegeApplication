import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:srkr/UnderConstruction.dart';
import 'package:srkr/nav_components.dart';
import 'package:srkr/pages/Faculty_loginpage.dart';

import 'package:srkr/pages/attendance.dart';

class FacultyProfile extends StatefulWidget {
  // Add these lines

  // You can pass necessary data to this page through the constructor
  const FacultyProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<FacultyProfile> createState() => _FacultyProfileState();
}

class _FacultyProfileState extends State<FacultyProfile> {
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
            .child('1eR_AQCaIdNlbWN_PCLgUlrEDq-X31JvNvClg_n7SUV0')
            .child('FacultyInfo')
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
            final id = userRecord['id'] ?? 'No Data Found';
            final department = (userRecord['department'] ?? 'No Data Found')
                .toString(); // Convert to String
            final invigilation_date =
                (userRecord['invigilation_date'] ?? 'No Data Found')
                    .toString(); // Convert to String
            final invigilation_dno =
                (userRecord['invigilation_dno'] ?? 'No Data Found')
                    .toString(); // Convert to String
            final invigilation_place =
                (userRecord['invigilation_place'] ?? 'No Data Found')
                    .toString();
            return {
              'name': name,
              'id': id,
              'department': department,
              'invigilation_date': invigilation_date,
              'invigilation_dno': invigilation_dno,
              'invigilation_place': invigilation_place,
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
              MaterialPageRoute(builder: (context) => AttendanceTake()));
          break;
        case 3:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UnderConstructionPage()));
          break;
        case 4:
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
            'Faculty Profile',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-Medium',
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(loggedInEmail), //
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print(snapshot.data);
            return Center(
              child: AlertDialog(
                backgroundColor: Colors.red,
                title: Center(
                  child: Text(
                    'Your Not Faculty of College',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          } else {
            // Use the retrieved user data here
            final userData = snapshot.data!;
            return ListView(
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
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                                          userData['id'] ?? 'No Data Found',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins-Regular',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       userData['year'] + "/4" ??
                                        //           'No Data Found',
                                        //       style: const TextStyle(
                                        //         fontSize: 15,
                                        //         fontFamily: 'Poppins-Medium',
                                        //       ),
                                        //     ),
                                        //     const SizedBox(width: 5),
                                        //     Text(
                                        //       userData['branch'] ?? 'No Data Found',
                                        //       style: const TextStyle(
                                        //         fontSize: 15,
                                        //         fontFamily: 'Poppins-Medium',
                                        //       ),
                                        //     ),
                                        //     const SizedBox(width: 5),
                                        //     Text(
                                        //       userData['section'] ?? 'No Data Found',
                                        //       style: const TextStyle(
                                        //         fontSize: 15,
                                        //         fontFamily: 'Poppins-Medium',
                                        //       ),
                                        //     ),
                                        //     const SizedBox(width: 5),
                                        //   ],
                                        // ),
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
                    Card(
                      elevation: 0.4,
                      color: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment,
                          children: [
                            Text(
                              'Invigilation duty',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF37474F),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 35, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Add some spacing between the top of the card and the title
                                  Text(
                                    'Place',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 15,
                                      color: Color(0xFF37474F),
                                    ),
                                  ),
                                  Spacer(),
                                  // Add a subtitle widget
                                  Text(
                                    "Room No",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 15,
                                      color: Color(0xFF37474F),
                                    ),
                                  ),
                                  Spacer(),
                                  // Add some spacing between the subtitle and the text
                                  // Add a text widget to display some text
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 15,
                                      color: Color(0xFF37474F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 20, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['invigilation_place'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "          " + userData['invigilation_dno'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    userData['invigilation_date'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Faculty Remarks',
                            icon: Icons.rate_review,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 1),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Take Attendance',
                            icon: Icons.card_membership,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 2),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'About Us',
                            icon: Icons.info,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 3),
                          ),
                          const SizedBox(height: 15),
                          DrawerItem(
                            name: 'Sign Out',
                            icon: Icons.exit_to_app,
                            textColor: Colors.black,
                            onPressed: () => onItemPressed(context, index: 4),
                          ),
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
// 