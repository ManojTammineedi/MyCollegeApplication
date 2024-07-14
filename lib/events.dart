import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srkr/image_slider.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .orderBy('order')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error: Unable to load data');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final events = snapshot.data!.docs;
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

        return Column(
          children: events.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            String originalDescription = data['description'] ?? '';
            String modnews = limitText(originalDescription, 12);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 120,
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
                              data['cal_img'],
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins-Medium'),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  modnews,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Poppins-Regular'
                                  ),
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
        );
      },
    );
  }
}
