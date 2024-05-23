import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'latest_announcments.dart';
import 'schedule_coach.dart';
import 'sessions_coach.dart';


class CoachHomeScreen extends StatelessWidget {
  const CoachHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today’s Schedule',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: TodayScheduleCoach(),
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sessions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              child: SessionsCoach(),
              padding: EdgeInsets.symmetric(vertical: 6),
              // child: SpacedItemsList(),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Club's Latest Announcement",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: LatestAnnouncement(),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

