import 'package:flutter/material.dart';

class NotesInfo extends StatefulWidget {
  final String subject;

  NotesInfo({required this.subject});

  @override
  State<NotesInfo> createState() => _NotesInfoState();
}

class _NotesInfoState extends State<NotesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      // Add details content here based on the selected item (subject),
    );
  }
}
