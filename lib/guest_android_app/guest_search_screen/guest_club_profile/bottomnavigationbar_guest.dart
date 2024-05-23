import 'package:flutter/material.dart';

class GuestBottomNavigationBar extends StatefulWidget {
  const GuestBottomNavigationBar({super.key});

  @override
  State<GuestBottomNavigationBar> createState() =>
      _GuestBottomNavigationBarState();
}

class _GuestBottomNavigationBarState extends State<GuestBottomNavigationBar> {
  var currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: const Color.fromRGBO(210, 230, 255, 1),
      selectedIndex: currentPageIndex,
      backgroundColor: const Color.fromRGBO(236, 238, 243, 1),
      onDestinationSelected: (int index) {
        setState(() {
          Navigator.of(context).pop(index);
        });
      },
      destinations: const [
        NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.black),
            icon: Icon(Icons.home_outlined),
            label: 'Home'),
        NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month, color: Colors.black),
            icon: Icon(Icons.search_outlined),
            label: 'Search'),
        NavigationDestination(
            selectedIcon: Icon(Icons.campaign_outlined, color: Colors.black),
            icon: Icon(Icons.campaign_outlined, color: Colors.grey),
            label: 'Feed'),
        NavigationDestination(
            selectedIcon: Icon(Icons.people, color: Colors.black),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile'),
      ],
    );
  }
}
