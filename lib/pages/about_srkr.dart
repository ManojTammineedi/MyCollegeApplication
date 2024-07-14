import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AboutSrkr extends StatefulWidget {
  const AboutSrkr({super.key});

  @override
  State<AboutSrkr> createState() => _AboutSrkrState();
}

class _AboutSrkrState extends State<AboutSrkr> {
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              'About SRKR College',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regular',
              ),
            ),
            SizedBox(height: 10), // Add some space between text and image
            // Use AspectRatio to maintain the aspect ratio of the image

            Card(
              child: Image.asset(
                'lib/images/about_srkr.png',
                fit: BoxFit.cover, // or BoxFit.fill, BoxFit.fitHeight, etc.
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Vision and Mission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regular',
              ),
            ),
            SectionWidget(
                title: 'VISION:',
                content:
                    'To emerge as a world-class technical institution that strives for the socio-ecological well-being of the society.'),
            SectionWidget(
                title: 'MISSION:',
                content:
                    'To upgrade teaching-learning environment with state-of-the-art infrastructure to accelerate employability and entrepreneurship.\nTo promote inter-disciplinary research and innovation through institute–industry partnership.\nTo nurture ethical and ecological consciousness to sustain the holistic social well-being.'),
            SectionWidget(
                title: 'QUALITY POLICY:',
                content:
                    'The college is committed to achieving excellence in Teaching, Research and Consultancy:\n\nBy deploying global best practices in education to create world-class professionals\nBy establishing harmonious relationships with industry and society\nBy developing state-of-the-art infrastructure and sustaining the quality of education through well-endowed faculty\nBy imparting knowledge through advanced learning and teaching methods.'),
          ],
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final String content;

  const SectionWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // elevation: 2,
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Regular'),
              ),
              SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
