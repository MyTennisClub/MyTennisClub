import 'package:flutter/material.dart';
import 'coach_schedule/schedule_coach.dart';
import 'coach_sessions/sessions_coach.dart';


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
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
              child: const TodayScheduleCoach(),
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
            flex: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              // child: SpacedItemsList(),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
              child: const SessionsCoach(),
            ),
          ),
        ],
      ),
    );
  }
}

