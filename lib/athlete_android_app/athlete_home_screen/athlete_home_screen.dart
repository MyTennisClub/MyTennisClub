import 'package:flutter/material.dart';
import 'reservations_ui.dart';
import '../Reservation.dart';

class AthleteHomeScreen extends StatelessWidget {
  final List<Reservation> reservations;

  const AthleteHomeScreen({Key? key, required this.reservations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Reservation> sortedReservations = [...reservations];
    sortedReservations.sort((a, b) => a.startTime.compareTo(b.startTime));

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
              child: UpcomingReservations(
                reservations: sortedReservations,
              ),
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
            ),
          ),
        ],
      ),
    );
  }
}

