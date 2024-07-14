import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() => runApp(FlashNews());

class FlashNews extends StatelessWidget {
  @override

// root of the application
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marquee',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GeeksForGeeks'),
          backgroundColor: Colors.green,
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 50.0),
          children: [
            _buildMarquee(),
            _buildComplexMarquee(),
          ].map(_wrapWithStuff).toList(),
        ),
      ),
    );
  }

// Primary Marquee text
  Widget _buildMarquee() {
    return Marquee(
      text: 'GeeksforGeeks.org was created'
          ' with a goal in mind to provide well written,'
          ' well thought and well explained solutions for'
          ' selected questions. The core team of five super geeks constituting'
          ' of technology lovers and computer science enthusiasts'
          ' have been constantly working in this direction ',
    );
  }

//Secondary Marquee text
  Widget _buildComplexMarquee() {
    return Marquee(
      text: 'GeeksforGeeks is a one-stop destination for programmers.',
      style: TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 3,
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }

// Styling the Marquee
  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(height: 50.0, color: Colors.white, child: child),
    );
  }
}
