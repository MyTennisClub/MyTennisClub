import 'package:flutter/material.dart';
import 'athlete_home_screen/athlete_home_screen.dart';
import 'athlete_schedule_screen/athlete_schedule_screen.dart';
import 'Reservation.dart';

class AthleteHomePage extends StatefulWidget {
  const AthleteHomePage({Key? key}) : super(key: key);

  @override
  State<AthleteHomePage> createState() => _AthleteHomePage();
}

class _AthleteHomePage extends State<AthleteHomePage> {
  int _currentIndex = 0;
  late List<Widget> _tabs;

  _AthleteHomePage() {
    _tabs = [
      HomeScreen(),
      ScheduleScreen(),
      const SearchScreen(),
      const FeedScreen(),
      const ProfileScreen(),
    ];
  }

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
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Schedule'),
            NavigationDestination(
                selectedIcon: Icon(Icons.search, color: Colors.black),
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
  // final List<Reservation> reservations;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AthleteHomeScreen(),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AthleteScheduleScreen();
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search Screen'),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Feed Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}