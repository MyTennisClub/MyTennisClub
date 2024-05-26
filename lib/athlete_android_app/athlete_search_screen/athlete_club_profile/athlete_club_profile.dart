import 'package:flutter/material.dart';
import 'athlete_club_profile_info.dart';

class ClubProfile extends StatefulWidget {
  const ClubProfile({super.key});

  @override
  State<ClubProfile> createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Info'),
    Tab(text: 'Announcement'),
    Tab(text: 'Reviews')
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          ClubInfo(),
          Center(
            child: Text("Announcements"),
          ),
          Center(
            child: Text("Reviews"),
          ),
        ],
      ),
    );
  }
}
