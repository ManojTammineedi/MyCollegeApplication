import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:srkr/image_slider.dart';

class ViewFull extends StatefulWidget {
  @override
  _ViewFullState createState() => _ViewFullState();
}

class _ViewFullState extends State<ViewFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'View All Stories',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins-Medium',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 20,
          color: Colors.black,
          icon: const Icon(Ionicons.chevron_back),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('topstories')
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
                String modnews = limitText(originalDescription, 10);

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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  data['image'],
                                  height: double.maxFinite,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['title'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-Medium',
                                      ),
                                    ),
                                 
                                    Text(
                                      modnews,
                                      style: const TextStyle(
                                        fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                    // const SizedBox(height: 10),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.blue.shade700,
                                          size: 15,
                                        ),
                                        // Text(
                                        //   data['rating'].toString(),
                                        //   style: const TextStyle(
                                        //     fontSize: 12,
                                        //   ),
                                        // ),
                                        // const Spacer(),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue,
                                            ),
                                            text: "Date: ${data['date']}",
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
    );
  }
}
