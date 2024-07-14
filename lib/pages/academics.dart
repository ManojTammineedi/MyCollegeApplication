import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Academics extends StatelessWidget {
  const Academics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Academic Calendar",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Bold-Poppins',
              ),
            ),
            Expanded(
              child: AcademicCalendarPage(),
            ),
            SizedBox(height: 16), // Adjust the spacing based on your needs
          ],
        ),
      ),
    );
  }
}

class AcademicCalendarPage extends StatefulWidget {
  const AcademicCalendarPage({Key? key}) : super(key: key);

  @override
  _AcademicCalendarPageState createState() => _AcademicCalendarPageState();
}

class _AcademicCalendarPageState extends State<AcademicCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('academic_calendar')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final documents = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final calendarData =
                documents[index].data() as Map<String, dynamic>;
            final title = calendarData['title'] ?? 'No Title';
            final imageUrl = calendarData['calendar'] ?? 'No Title';

            return AcademicCalendarCard(
              title: title,
              imageUrl: imageUrl,
            );
          },
        );
      },
    );
  }
}

class AcademicCalendarCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const AcademicCalendarCard({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Add some spacing between title and image

            // Wrap PhotoView with Image.network
            InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover, // Adjust the BoxFit based on your needs
              ),
            ),
          ],
        ),
      ),
    );
  }
}
