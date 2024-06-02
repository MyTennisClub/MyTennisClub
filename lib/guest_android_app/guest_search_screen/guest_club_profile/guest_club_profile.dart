import 'package:flutter/material.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_club_profile_review.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_club_profile_info.dart';
import 'package:mytennisclub/models/tennis_club.dart';

class ClubProfile extends StatefulWidget {
  final Function checkClubSelected;
  final List clubInfo;
  final int guestID;
  const ClubProfile(
      {required this.checkClubSelected,
      required this.clubInfo,
      required this.guestID,
      super.key});

  @override
  State<ClubProfile> createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Info'),
    Tab(text: 'Announcements'),
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
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                widget.checkClubSelected(false, 0);
              });
            }),
        title: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ClubInfo(info: widget.clubInfo, guestID: widget.guestID),
          const Center(
            child: Text("Announcements"),
          ),
          ClubReview(
            clubID: widget.clubInfo[0],
            guestID: widget.guestID,
          )
        ],
      ),
    );
  }
}
