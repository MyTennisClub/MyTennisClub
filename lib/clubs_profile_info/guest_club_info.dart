import 'bottomnavigationbar_guest.dart';
import 'package:flutter/material.dart';
import 'profile_buttons.dart';
import 'clubtext.dart';
import 'clubpicture.dart';
import 'book_court_buttons.dart';

class ClubInfo extends StatelessWidget {
  const ClubInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //leadingWidth: 35.0,
          title: const Text(
            'Patras Tennis Club',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.notifications,
                  size: 33,
                ),
                splashColor: Colors.transparent,
                tooltip: 'Show Notifications',
                highlightColor: Colors.transparent,
              ),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProfileButtons(),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClubPicture(),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClubText(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: BookCourtButtons(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CoachBottomNavigationBar(),
      ),
    );
  }
}
