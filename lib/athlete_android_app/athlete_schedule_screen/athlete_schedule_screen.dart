import 'package:flutter/material.dart';
import 'calendar.dart';

class Reservation {
  final String day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String description;

  Reservation(this.day, this.startTime, this.endTime, this.description);
}

class AthleteScheduleScreen extends StatelessWidget {
  const AthleteScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: const CalendarWidget(),
            ),
          ),
          ElevatedButton(onPressed: () {  },
            child: const Text('Book'),)
        ],
      ),
    );
  }
}
