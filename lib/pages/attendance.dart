import 'dart:io';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendanceTake extends StatefulWidget {
  @override
  _AttendanceTakeState createState() => _AttendanceTakeState();
}

class _AttendanceTakeState extends State<AttendanceTake> {
  List<String> section = <String>['A', 'B', 'C', 'D', 'E'];
  List<String> branch = <String>['CSE', 'IT', 'AIML', 'CSD', 'MECH'];
  List<String> subject = <String>[
    'Math',
    'Science',
    'English',
    'History',
    'Geography'
  ];
  String sectionValue = '';
  String branchValue = '';
  String subjectValue = '';
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .reference()
      .child('1JdinPdjMqu2yNJRN7awxsAefVWvok5qTLw7LShqQKu0')
      .child('Students');

  // Map to store attendance status for each redgno
  Map<String, String> attendanceStatus = {};

  @override
  void initState() {
    super.initState();
    sectionValue = section.first;
    branchValue = branch.first;
    subjectValue = subject.first;
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    try {
      DatabaseEvent event = await _databaseReference.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        List<dynamic> studentsData = snapshot.value as List<dynamic>;

        for (var studentData in studentsData) {
          if (studentData is Map<dynamic, dynamic> &&
              studentData.containsKey('redgno')) {
            String redgno = studentData['redgno'].toString();
            attendanceStatus[redgno] = 'na';
          }
        }

        print('Attendance Status after initialization: $attendanceStatus');
      }

      setState(() {
        // This setState should be outside the if block
      });
    } catch (error) {
      print('Error fetching data from the database: $error');
    }
  }

  Future<void> generatePDF(BuildContext context) async {
    try {
      final pdf = pw.Document();

      // Create a local copy of attendanceStatus
      Map<String, String> localAttendanceStatus = Map.from(attendanceStatus);

      // Extract absentees list
      final absenteesList = localAttendanceStatus.entries
          .where((entry) => entry.value == 'absent')
          .map((entry) => entry.key)
          .toList();

      // Check if there are absentees before adding a page
      if (absenteesList.isNotEmpty) {
        // Add title and absentees list to the page
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Center(
                    child: pw.Text('Absentees List',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Column(
                    children: absenteesList
                        .map((absentee) => pw.Text(absentee,
                            style: pw.TextStyle(fontSize: 12)))
                        .toList(),
                  ),
                ],
              );
            },
          ),
        );
      } else {
        print("No absentees to include in the PDF.");
        return; // Skip saving the PDF if there are no absentees
      }
      DateTime formattedDate = DateTime.now();
      String formattedDateStr = DateFormat('dd-MM-yyy').format(formattedDate);

      // Replace dots, spaces, and colons with underscores
      String sanitizedDate =
          formattedDateStr.replaceAll(RegExp(r'[:.\s]'), '_');
      String filename = "${sanitizedDate}_absentees_list.pdf";

      // Get the Downloads directory
      // Specify the path to the Downloads directory
      var path = "/storage/emulated/0/Download/";
      var downloadDir = Directory(path);

      // Check if the directory exists, create it if necessary
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      final file = File("${downloadDir.path}/$filename");
      await file.writeAsBytes(await pdf.save()); // Save the PDF
      print("PDF saved at: ${file.path}");
      final Uri url = Uri.parse(
          'https://drive.google.com/viewerng/viewer?embedded=true&url=${(file.path)}');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
      // Show a dialog box after downloading
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Download Successful"),
            content: Text(
                "The Absentees list has been downloaded successfully check your download files."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      // Open the downloaded PDF file
    } catch (e) {
      print("Error generating or saving PDF: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              children: [
                Container(
                  // padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 2.0, // Set the border width as needed
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius as needed
                  ),
                  child: DropdownButton<String>(
                    value: branchValue,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),

                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        branchValue = value!;
                      });
                    },
                    items: branch.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 2.0, // Set the border width as needed
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius as needed
                  ),
                  child: DropdownButton<String>(
                    value: sectionValue,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),

                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        sectionValue = value!;
                      });
                    },
                    items:
                        section.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Spacer(),
                Container(
                  // padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 2.0, // Set the border width as needed
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius as needed
                  ),
                  child: DropdownButton<String>(
                    value: subjectValue,
                    // icon: const Icon(Icons.arrow_downward),
                    elevation: 0,
                    style: const TextStyle(color: Colors.deepPurple),
                    
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        subjectValue = value!;
                      });
                    },
                    items:
                        subject.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     DropdownButtonFormField<String>(
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //       ),
          //       dropdownColor: Colors.white,
          //       hint: section.isEmpty
          //           ? Text('Section')
          //           : Text(
          //               section,
          //               style: TextStyle(color: Colors.blue, fontSize: 18),
          //             ),
          //       isExpanded: true,
          //       iconSize: 30.0,
          //       style: TextStyle(color: Colors.blue, fontSize: 18),
          //       items: ['A', 'B', 'C', 'D', 'E']
          //           .map(
          //             (val) => DropdownMenuItem<String>(
          //               value: val,
          //               child: Text(val),
          //             ),
          //           )
          //           .toList(),
          //       onChanged: (val) {
          //         setState(() {
          //           section = val!;
          //         });
          //       },
          //     ),
          //     SizedBox(width: 10), // Add some spacing between the dropdowns
          //     DropdownButtonFormField<String>(
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //       ),
          //       dropdownColor: Colors.white,
          //       hint: subject.isEmpty
          //           ? Text('Subject')
          //           : Text(
          //               subject,
          //               style: TextStyle(color: Colors.blue, fontSize: 18),
          //             ),
          //       isExpanded: true,
          //       iconSize: 30.0,
          //       style: TextStyle(color: Colors.blue, fontSize: 18),
          //       items: ['Math', 'Science', 'English', 'History', 'Geography']
          //           .map(
          //             (val) => DropdownMenuItem<String>(
          //               value: val,
          //               child: Text(val),
          //             ),
          //           )
          //           .toList(),
          //       onChanged: (val) {
          //         setState(() {
          //           subject = val!;
          //         });
          //       },
          //     ),
          //   ],
          // ),

          buildHeaderRow(),

          // Firebase Animated List
          Expanded(
            child: FirebaseAnimatedList(
              query: _databaseReference.orderByChild('redgno'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                if (snapshot.value != null) {
                  Map<dynamic, dynamic>? data =
                      snapshot.value as Map<dynamic, dynamic>?;

                  if (data != null) {
                    // Your logic to process the data
                    return buildAttendanceRow(data);
                  }
                } else {
                  // Print a more detailed error message for debugging
                  print("DataSnapshot value is null. Snapshot: $snapshot");
                }
                return const SizedBox
                    .shrink(); // Return an empty widget if data is null
              },
            ),
          ),
          // Submit Button

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  generatePDF(context);
                },
                child: Text('Download Absentees List'),
              ),
              ElevatedButton(
                onPressed: () {
                  submitAttendance();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeaderRow() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Sno',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
              ),
            ),
            Spacer(),
            Text(
              'RedgNo',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
              ),
            ),
            Spacer(),
            Text(
              'Present',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
              ),
            ),
            Spacer(),
            Text(
              'Absent',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
              ),
            ),
            Spacer(),
            Text(
              'NA',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAttendanceRow(Map<dynamic, dynamic> data) {
    final redgno = data['redgno'];

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${data['sno'].toString() + "." ?? 'No Data'}'),
                  Spacer(),
                  Text('${data['redgno'] ?? 'No Data'}'),
                  Spacer(),
                  Radio(
                    value: 'present',
                    groupValue: attendanceStatus[redgno],
                    onChanged: (value) {
                      setState(() {
                        attendanceStatus[redgno] = value?.toString() ?? '';
                      });
                    },
                  ),
                  Text('Present'),
                  Spacer(),
                  Radio(
                    value: 'absent',
                    groupValue: attendanceStatus[redgno],
                    onChanged: (value) {
                      setState(() {
                        attendanceStatus[redgno] = value?.toString() ?? '';
                      });
                    },
                  ),
                  Text('Absent'),
                  Spacer(),
                  Radio(
                    value: 'na',
                    groupValue: attendanceStatus[redgno],
                    onChanged: (value) {
                      setState(() {
                        attendanceStatus[redgno] = value?.toString() ?? '';
                      });
                    },
                  ),
                  Text('NA'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitAttendance() {
    DatabaseReference attendanceRef =
        FirebaseDatabase.instance.reference().child('Attendance');

    // Check if all radio buttons are filled
    void submitAttendance() {
      // Check if any 'NA' values are present after taking attendance
      bool hasNAValues =
          attendanceStatus.values.any((status) => status == 'na');

      if (hasNAValues) {
        // Display an error message if any 'NA' values are still present
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Please fill in all attendance statuses.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Do not proceed to update the database
      }
    }

    // If all radio buttons are filled, proceed to update the database
    for (var redgno in attendanceStatus.keys) {
      String status = attendanceStatus[redgno] ?? '';
      int incrementValue = 2;

      // Initialize the updates map
      Map<String, dynamic> updates = {};

      // Check each column status
      if (status == 'present') {
        // If marked as present, increment 'subject1' and 'total'
        updates['subject1'] = ServerValue.increment(incrementValue);
        updates['total'] = ServerValue.increment(incrementValue);
        print('Attendance marked as present for $redgno');
      } else {
        // If not marked or marked as absent, increment only 'total'
        updates['total'] = ServerValue.increment(incrementValue);
        print('Attendance marked as absent or not marked for $redgno');
      }

      // Update the specific redgno with the constructed map
      attendanceRef.child(redgno).update(updates);
    }

    setState(() {
      attendanceStatus.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Attendance submitted successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AttendanceTake(),
  ));
}
