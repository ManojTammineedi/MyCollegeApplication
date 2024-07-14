import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:srkr/notes-cse.dart';

class Notes1 extends StatefulWidget {
  @override
  State<Notes1> createState() => _Notes1State();
}

class _Notes1State extends State<Notes1> {
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          Row(
            children: [
              Text(
                'First Year',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          NotesCse(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Second Year',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          NotesCse(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Third Year',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          NotesCse(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Fourth Year',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
           const SizedBox(
            height: 10,
          ),
          NotesCse(),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Notes1(),
  ));
}
