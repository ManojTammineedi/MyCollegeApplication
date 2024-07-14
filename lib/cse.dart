// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:srkr/UnderConstruction.dart';
// import 'package:srkr/pdf_view.dart';
// import 'package:srkr/place.dart';
// import 'package:srkr/placements_page.dart';
// import 'package:srkr/search.dart';

// class CSE extends StatefulWidget {
//   @override
//   _CSEState createState() => _CSEState();
// }

// class _CSEState extends State<CSE> {
//   int _expandedPanelIndex = -1;

//   void _handleTap(int index) {
//     setState(() {
//       _expandedPanelIndex = (_expandedPanelIndex == index) ? -1 : index;
//     });
//   }

//   bool _isPanelExpanded(int index) {
//     return _expandedPanelIndex == index;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//         title: const Text(
//           "Search for notes",
//           style: TextStyle(fontFamily: 'Bold-Poppins'),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(context: context, delegate: CustomSearch());
//             },
//             color: Colors.black,
//             icon: const Icon(Icons.search),
//           )
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.all(14),
//         children: [
//           // Center(
//           //   child: Text(
//           //     'Welcome to CSE Department',
//           //     style: TextStyle(
//           //       fontSize: 24,
//           //       fontWeight: FontWeight.bold,
//           //       fontFamily: 'Poppins-Medium',
//           //     ),
//           //   ),
//           // ),
//           // SizedBox(
//           //   height: 30,
//           // ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//             child: Row(
//               children: [
//                 Text(
//                   'FAULTY INFORMATION',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins-Regular',
//                   ),
//                 ),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your button click logic here
//                   },
//                   child: Text('View'),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'SYLLABUS & MODEL PAPERS',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Poppins-Regular',
//               ),
//             ),
//           ),
//           CustomExpansionPanelList(items: [
//             CustomExpansionPanelItem(
//               headerBuilder: (BuildContext context, bool isExpanded) {
//                 return ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             size: 20,
//                             color: Colors.orange,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             'R20 SYLLABUS AND MODEL PAPERS',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Poppins-Light',
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text(
//                             'Tap here to see',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Colors.black54,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               body: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       child: Row(
//                         children: [
//                           Text(
//                             'SYLLABUS',
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           ),
//                           Spacer(),
//                           Text(
//                             'MODEL PAPERS',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       child: Row(
//                         children: [
//                           PDFItem(context, 'I Year Syllabus ',
//                               'I-R20-CSE-SYLLABUS.pdf'),
//                           Spacer(),
//                           PDFItem(context, 'I Year Model Papers ',
//                               'I-R20-CSE-MODEL-PAPERS'),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       child: Row(
//                         children: [
//                           PDFItem(context, 'II Year Syllabus ',
//                               'II-R20-CSE-SYLLABUS.pdf'),
//                           Spacer(),
//                           PDFItem(context, 'II Year Model Papers ',
//                               'II-R20-CSE-MODEL-PAPERS'),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       child: Row(
//                         children: [
//                           PDFItem(context, 'III Year Syllabus ',
//                               'III-R20-CSE-SYLLABUS.pdf'),
//                           Spacer(),
//                           PDFItem(context, 'III Year Model Papers ',
//                               'III-R20-CSE-MODEL-PAPERS'),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       child: Row(
//                         children: [
//                           PDFItem(context, 'IV Year Syllabus ',
//                               'IV-R20-CSE-SYLLABUS.pdf'),
//                           Spacer(),
//                           PDFItem(context, 'IV Year Model Papers ',
//                               'IV-R20-CSE-MODEL-PAPERS'),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             )
//           ]),

//           GestureDetector(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Notes',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins-Regular',
//                     ),
//                   ),
//                   Spacer(),
//                   Icon(Icons.arrow_forward)
//                 ],
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 PageRouteBuilder(
//                   pageBuilder: (_, __, ___) => UnderConstructionPage(),
//                   transitionDuration: Duration(milliseconds: 500),
//                   transitionsBuilder: (_, a, __, c) =>
//                       FadeTransition(opacity: a, child: c),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MaterialApp(
//     home: CSE(),
//   ));
// }
