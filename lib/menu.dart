import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Ionicons.home_outline),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.newspaper_outline),
          label: "News",
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.book_outline),
          label: "Resources",
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.podium_outline),
          label: "Results",
        ),
      ],
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins-Regular',
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Poppins-Regular',
      ),
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
