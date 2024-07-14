import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class eventsection extends StatelessWidget {
  final String image;
  final String date;
  final String title;
  final String description;

  const eventsection({
    Key? key,
    required this.image,
    required this.date,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: size.height * 0.60,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          // IconButton(
                          //   iconSize: 20,
                          //   onPressed: () {},
                          //   icon: const Icon(Ionicons.heart_outline),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date', // Display the location
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date, // You can replace this with relevant data
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 4),
                //   child: IconButton(
                //     onPressed: () {},
                //     iconSize: 20,
                //     icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              child: Text(
                title, // You can replace this with relevant data
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text(
                    //   "01d:32h:56m", // You can replace this with relevant data
                    //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    //         color: Theme.of(context).colorScheme.primary,
                    //       ),
                    // ),
                    // const SizedBox(height: 5),
                    // Text(
                    //   "Started in", // You can replace this with relevant data
                    //   style: Theme.of(context).textTheme.bodySmall,
                    // ),

                    // const SizedBox(height: 5),
                    // Text(
                    //   "Description", // You can replace this with relevant data
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.w800,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              height: 180,
              width: double.maxFinite,
              child: Column(
                children: [
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  )
                  // Your other content, like the image, can be added here
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               HomePage()), // Navigate to NewPage()
            //     );
            //   },
            // child: Container(
            //   height: 180,
            //   width: double.maxFinite,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color:
            //         Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            //     image: const DecorationImage(
            //       image: AssetImage('lib/images/map.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // ),
            const SizedBox(height: 15),
            // Distance(
            //   fromLocation: 'Accra', // Your starting location
            //   toLocation: location, // Use the location from Firestore
            // ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => HomePage())),
            //   style: ElevatedButton.styleFrom(
            //     elevation: 0,
            //     shape: const StadiumBorder(),
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 15,
            //       horizontal: 8.0,
            //     ),
            //   ),
            //   child: const Text("Join this tour"),
            // ),
          ],
        ),
      ),
    );
  }
}
