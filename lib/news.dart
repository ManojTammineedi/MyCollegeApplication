import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srkr/home_page.dart';
import 'package:srkr/image_slider.dart';
import 'package:srkr/menu.dart';
import 'package:srkr/notes_page.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  int _currentIndex = 1;
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
          'News',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Bold-Poppins',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('news')
            .orderBy('order')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: Unable to load data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final nearbyPlaces = snapshot.data!.docs;
          String limitText(String text, int limit) {
            List<String> words = text.split(' ');

            if (words.length <= limit) {
              // No need to truncate if the text is within the limit
              return text;
            } else {
              // Truncate the text and join the words
              String limitText = words.take(limit).join(' ');

              // Add ellipsis (...) at the end
              return '$limitText...';
            }
          }

          return SingleChildScrollView(
            child: Column(
              children: nearbyPlaces.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                String originalDescription = data['description'] ?? '';
                String modnews = limitText(originalDescription, 15);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 135,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => imageslider(
                                image: data['image'],
                                date: data['date'],
                                title: data['title'],
                                description: data['description'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(12),
                              //   child: Image.network(
                              //     data['image'],
                              //     height: double.maxFinite,
                              //     width: 130,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['title'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      modnews,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    // const SizedBox(height: 10),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        // const SizedBox(width: 15),
                                        // Icon(
                                        //   Icons.calendar_month_outlined,
                                        //   color: Colors.blue.shade700,
                                        //   size: 15,
                                        // ),
                                        // Text(
                                        //   data['rating'].toString(),
                                        //   style: const TextStyle(
                                        //     fontSize: 12,
                                        //   ),
                                        // ),
                                        // const Spacer(),
                                        const SizedBox(width: 5),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: const Color.fromARGB(
                                                  255, 158, 167, 174),
                                            ),
                                            text: "Added on: ${data['date']}",
                                          ),
                                        ),
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
                );
              }).toList(),
            ),
          );
        },
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
}
