import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class PDFItem extends StatefulWidget {
  final BuildContext context;
  final String text;
  final String pdfFileName;

  PDFItem(this.context, this.text, this.pdfFileName);

  @override
  _PDFItemState createState() => _PDFItemState();
}

class _PDFItemState extends State<PDFItem> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await downloadAndOpenPDF(context);
      },
      child: Center(
        child: _isLoading
            ? Lottie.asset('lib/images/loading.json', height: 100, width: 100)
            : Text(
                widget.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
      ),
    );
  }

  Future<void> downloadAndOpenPDF(BuildContext context) async {
    final String localPath = (await getApplicationDocumentsDirectory()).path;
    final String localPDFPath = '$localPath/${widget.pdfFileName}';

    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(widget.pdfFileName);

    try {
      setState(() {
        _isLoading = true;
      });

      await ref.writeToFile(File(localPDFPath));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PDFViewer(filePath: localPDFPath, text: widget.text),
        ),
      );
    } catch (e) {
      print('Error downloading PDF: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class PDFViewer extends StatefulWidget {
  final String filePath;
  final String text;

  PDFViewer({required this.filePath, required this.text});
  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.text,
           style: TextStyle(color: Colors.black),
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
      body: PDFView(
        filePath: widget.filePath,
        autoSpacing: false,
        pageFling: false,
      ),
    );
  }
}
