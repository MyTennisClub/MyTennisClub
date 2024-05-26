import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'coach_schedule/schedule_coach.dart';
import 'coach_sessions/sessions_coach.dart';


class CoachHomeScreen extends StatelessWidget {
  const CoachHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          Container(
            child: const Align(
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
            child: Container(
                color: Colors.grey.shade300,

                child: const TodayScheduleCoach()
            ),
          ),
          Container(
            child: const Align(
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
            child: Container(
              child: const SessionsCoach()
            ),
          ),
        ],
      ),
    );
  }
}

