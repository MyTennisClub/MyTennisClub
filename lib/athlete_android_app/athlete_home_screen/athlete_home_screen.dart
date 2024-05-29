import 'package:flutter/material.dart';
import 'reservations_ui.dart';



class AthleteHomeScreen extends StatelessWidget {
  // final List<Reservation> reservations;
  const AthleteHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
              child: UpcomingReservations(),
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
