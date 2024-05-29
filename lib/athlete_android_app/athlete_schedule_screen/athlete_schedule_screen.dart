import 'package:flutter/material.dart';
import 'calendar.dart';


class AthleteScheduleScreen extends StatelessWidget {

  const AthleteScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: CalendarWidget(), // Pass reservations to CalendarWidget
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: ElevatedButton(
              onPressed: () {
                // Handle booking private session
              },
              child: const Text('Book Private Session'),
            ),
          )
        ],
      ),
    );
  }
}
