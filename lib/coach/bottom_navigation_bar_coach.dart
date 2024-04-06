import 'package:flutter/material.dart';


class CoachBottomNavigationBar extends StatefulWidget {
  const CoachBottomNavigationBar({super.key});

  @override
  State<CoachBottomNavigationBar> createState() =>
      _CoachBottomNavigationBarState();
}

class _CoachBottomNavigationBarState extends State<CoachBottomNavigationBar> {
  var currentPageIndex = 0;
  var pressed = false;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      indicatorColor: Colors.white10,
      selectedIndex: currentPageIndex,
      backgroundColor: Colors.white,
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.black),
          icon: Icon(Icons.home, color: Colors.grey),
          label: 'Home'),
        NavigationDestination(
          selectedIcon: Icon(Icons.calendar_month, color: Colors.black),
          icon: Icon(Icons.calendar_month, color: Colors.grey),
          label: 'Schedule'),
        NavigationDestination(
          selectedIcon: Icon(Icons.sports_tennis, color: Colors.black),
          icon: Icon(Icons.sports_tennis, color: Colors.grey),
          label: 'Trainning'),
        NavigationDestination(
            selectedIcon: Icon(Icons.people, color: Colors.black),
            icon: Icon(Icons.people, color: Colors.grey),
            label: 'Athletes'),
        NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.black),
            icon: Icon(Icons.person, color: Colors.grey),
            label: 'Profile')
      ],
    );
  }
}


