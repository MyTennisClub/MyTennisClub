import 'package:flutter/material.dart';
import 'coach_home_screen/coach_home_screen.dart';
import 'coach_schedule_screen/coach_schedule_screen.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  _CoachHomePageState createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const ScheduleScreen(),
    const TrainningScreen(),
    const AthletesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Patras Tennis Club',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.arrow_drop_down, size: 35.0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        ),
        leadingWidth: 35.0,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.notifications,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        // indicatorColor: Colors.white10,
        selectedIndex: _currentIndex,
        // backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
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
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoachHomeScreen();
  }
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoachScheduleScreen();
  }
}

class TrainningScreen extends StatelessWidget {
  const TrainningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Trainning Screen'),
    );
  }
}

class AthletesScreen extends StatelessWidget {
  const AthletesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Athetes Screen'),
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
