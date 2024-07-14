import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:srkr/pages/FacultyInfo.dart';

class FacultyTile extends StatefulWidget {
  @override
  State<FacultyTile> createState() => _FacultyTileState();
}

class _FacultyTileState extends State<FacultyTile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 20,
          color: Colors.black,
          icon: const Icon(Ionicons.chevron_back),
        ),
        title: Text(
          'Faculty',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Bold-Poppins',
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('faculty').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error: Unable to load data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          final events = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: events.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacultyInfo(
                        name: data['name'],
                        image: data['img'],
                        position: data['position'],
                        description: data['description'],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFEEE0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    children: <Widget>[
                      Container(
                        // Adjust margins as needed
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange, // Border color
                            width: 2.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            data['img'],
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(width: 17),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data['name'],
                            style: TextStyle(
                                color: Color(0xffFC9535), fontSize: 19),
                          ),
                          SizedBox(height: 2),
                          Text(
                            data['position'],
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                        decoration: BoxDecoration(
                          color: Color(0xffFBB97C),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text(
                          "View",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
