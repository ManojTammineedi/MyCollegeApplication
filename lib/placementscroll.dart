import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:srkr/image_slider.dart';

class placementScroll extends StatefulWidget {
  const placementScroll({Key? key}) : super(key: key);

  @override
  _placementScrollState createState() => _placementScrollState();
}

class _placementScrollState extends State<placementScroll> {
  late PageController _pageController;
  late Timer _timer;
  late List<QueryDocumentSnapshot> recommendedPlaces;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    recommendedPlaces = [];

    // Set up a timer to move to the next page every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_pageController.page! < recommendedPlaces.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // Move quickly to the first page and start again
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('topstories')
            .orderBy('order')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Error: Unable to load data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          recommendedPlaces = snapshot.data!.docs;

          return PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final data =
                  recommendedPlaces[index].data() as Map<String, dynamic>;
              return SizedBox(
                width: 100,
                child: Card(
                  elevation: 0.4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(120),
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
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              data['image'],
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                              height: 250,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: recommendedPlaces.length,
          );
        },
      ),
    );
  }
}
