import 'package:flutter/material.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_search_screen.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePage();
}

int _currentIndex = 0;

class _GuestHomePage extends State<GuestHomePage> {
  final List<Widget> _tabs = [
    const HomeScreen(),
    const SearchScreen(),
    const FeedScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(236, 238, 243, 1),
          title: const Text('MyTennisClub',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 27,
                ),
                tooltip: 'Show Notifications',
              ),
            ),
          ],
        ),
        body: _tabs[_currentIndex],
        bottomNavigationBar: NavigationBar(
          indicatorColor: const Color.fromRGBO(210, 230, 255, 1),
          selectedIndex: _currentIndex,
          backgroundColor: const Color.fromRGBO(236, 238, 243, 1),
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
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
                selectedIcon:
                    Icon(Icons.campaign_outlined, color: Colors.black),
                icon: Icon(Icons.campaign_outlined, color: Colors.grey),
                label: 'Feed'),
            NavigationDestination(
                selectedIcon: Icon(Icons.people, color: Colors.black),
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuestsSearchScreen();
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Feed Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}
