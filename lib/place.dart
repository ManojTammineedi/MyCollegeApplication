import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Placements extends StatefulWidget {
  @override
  _PlacementsState createState() => _PlacementsState();
}

class _PlacementsState extends State<Placements> {
  late List<Map<String, dynamic>> _firebaseData;
  bool _isInitiallyExpanded = true;
  @override
  void initState() {
    super.initState();

    _firebaseData = []; // Initialize with an empty list

    // Replace 'your_collection' with your actual Firestore collection name
    FirebaseFirestore.instance.collection('placements').get().then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _firebaseData.add(doc.data() as Map<String, dynamic>);
        });
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Placements',
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          // Placement summaries heading
          // placementScroll(),
          // Padding(
          //   padding: const EdgeInsets.(15.0),
          //   child:
          Text(
            'SUMMARY OF PLACEMENTS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // ),
          SizedBox(
            height: 10,
          ),
          // Placement summaries in rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlacementSummary(year: '2022-23', count: 1866),
              PlacementSummary(year: '2021-22', count: 2715),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlacementSummary(year: '2020-21', count: 1435),
              PlacementSummary(year: '2019-20', count: 968),
            ],
          ),
          // CustomExpansionPanel
          SizedBox(
            height: 30,
          ),
          Text(
            'PLACEMENT STATISTICS:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomExpansionPanelList(
            items: [
              for (int i = 0; i < _firebaseData.length; i++)
                CustomExpansionPanelItem(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        _firebaseData[i]['year'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        _isInitiallyExpanded
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                      ),
                      onTap: () {
                        setState(() {
                          _isInitiallyExpanded = !_isInitiallyExpanded;
                        });
                      },
                    );
                  },
                  body: _buildPanelContent(_firebaseData[i]),
                  isExpanded: _isInitiallyExpanded,
                ),
              // Add more CustomExpansionPanelItem instances as needed
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPanelContent(Map<String, dynamic> data) {
    List<String> imageUrls = (data['image'] as List<dynamic>).cast<String>();
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Display images from the imageUrls list
        for (String imageUrl in imageUrls)
          Container(
            width: screenWidth, // Adjust width as needed
            height: 800, // Adjust height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.circular(10), // Adjust border radius as needed
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
      ],
    );
  }
}

class PlacementSummary extends StatelessWidget {
  final String year;
  final int count;

  PlacementSummary({required this.year, required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            year,
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            count.toString(),
            style: TextStyle(
                color: Colors.blue.shade800,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CustomExpansionPanelList extends StatefulWidget {
  const CustomExpansionPanelList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CustomExpansionPanelItem> items;

  @override
  _CustomExpansionPanelListState createState() =>
      _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.items[index].isExpanded = !isExpanded;
        });
      },
      children:
          widget.items.map<ExpansionPanel>((CustomExpansionPanelItem item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return item.headerBuilder(context, item.isExpanded);
          },
          body: item.body,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class CustomExpansionPanelItem {
  CustomExpansionPanelItem({
    required this.headerBuilder,
    required this.body,
    this.isExpanded = false,
  });

  final Widget Function(BuildContext, bool) headerBuilder;
  final Widget body;
  bool isExpanded;
}

void main() {
  runApp(MaterialApp(
    home: Placements(),
  ));
}
