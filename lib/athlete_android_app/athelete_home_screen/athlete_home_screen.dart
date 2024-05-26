import 'package:flutter/material.dart';
import 'reservations_ui.dart';
import 'Reservation.dart';



List<Reservation> reservations = [
  Reservation(
    id: 1,
    title: 'ATH Tennis',
    court: 'Court A',
    startTime: DateTime.parse('2024-08-04 12:00:00'),
    endTime: DateTime.parse('2024-08-04 13:00:00'),
  ),
  Reservation(
    id: 2,
    title: 'ATH Tennis',
    court: 'Court B',
    startTime: DateTime.parse('2024-08-04 14:00:00'),
    endTime: DateTime.parse('2024-08-04 15:00:00'),
  ),
  Reservation(
    id: 3,
    title: 'ATH Tennis',
    court: 'Court C',
    startTime: DateTime.now().add(const Duration(hours: 1)),
    endTime: DateTime.now().add(const Duration(hours: 2)), // Example of upcoming reservation
  ),
  // Add more reservations here
];

// Sort reservations by start time


// Sort reservations by start time

class AthleteHomeScreen extends StatelessWidget {
  const AthleteHomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    reservations.sort((a, b) => a.startTime.compareTo(b.startTime));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          Container(
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Upcoming Reservations',
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
              child:  UpcomingReservations(
                reservations: reservations,
              ),
              // child: const Text("data")
            ),
          ),
          Container(
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Messages',
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
              // child: const Text('Data')
            ),
          ),
        ],
      ),
    );
  }
}
