import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srkr/Notes_info.dart';

class CustomSearch extends SearchDelegate {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, query);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults();
  }

  Widget buildSearchResults() {
    return FutureBuilder(
      future: fetchDataFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there's an error
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          // Handle the case where data is null
          return Text('No data available');
        } else {
          // If data is available
          List<String> matchQuery = [];
          for (var item in snapshot.data!) {
            if (item.toLowerCase().contains(query.toLowerCase())) {
              matchQuery.add(item);
            }
          }

          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text(result),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotesInfo(
                          subject: result,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<String>> fetchDataFromFirebase() async {
    QuerySnapshot querySnapshot = await _firestore.collection('notes').get();
    List<String> data = querySnapshot.docs
        .map((DocumentSnapshot document) => document['subject'] as String)
        .toList();
    return data;
  }
}
