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
        elevation: 1,
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.black,
                size: 30,
              ),
              icon: Icon(
                Icons.home,
                color: Colors.grey,
                size: 30,
              ),
              label: 'Home'),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: 30,
              ),
              icon: Icon(
                Icons.search_rounded,
                color: Colors.grey,
                size: 30,
              ),
              label: 'Search'),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.announcement_outlined,
                color: Colors.black,
                size: 30,
              ),
              icon: Icon(
                Icons.announcement_outlined,
                color: Colors.grey,
                size: 30,
              ),
              label: 'Feed'),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.person_outline_sharp,
                color: Colors.black,
                size: 30,
              ),
              icon: Icon(
                Icons.person_outline_sharp,
                color: Colors.grey,
                size: 30,
              ),
              label: 'Profile')
        ]);
  }
}
