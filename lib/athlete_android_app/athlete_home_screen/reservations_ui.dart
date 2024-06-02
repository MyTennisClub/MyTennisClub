import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytennisclub/models/reservation.dart';

class UpcomingReservations extends StatefulWidget {
  const UpcomingReservations({super.key});

  @override
  _UpcomingReservationsState createState() => _UpcomingReservationsState();
}

class _UpcomingReservationsState extends State<UpcomingReservations> {
  late Future<Map<int, dynamic>> _reservationsFuture;

  @override
  void initState() {
    super.initState();
    _reservationsFuture = Reservation.getUpcomingRes(1);
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, dynamic>>(
      future: _reservationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('An error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Reservations For Today'));
        } else {
          final reservations = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: reservations.entries
                  .map((entry) => GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.9,
                        child: Container(
                          child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              double modalHeight = constraints.maxHeight;
                              final reservation = entry.value;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        'Reservation Info',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    SizedBox(
                                      height: modalHeight - modalHeight / 3,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Text(reservation['club_name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                            Text(reservation['court_name'],style: const TextStyle(fontSize: 18)),
                                            Text(DateFormat('dd-MM-yyyy').format(reservation['start_time']),style: const TextStyle(fontSize: 18)),
                                            Text('${DateFormat('HH:mm').format(reservation['start_time'])} - ${DateFormat('HH:mm').format(reservation['end_time'])}',style: const TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ElevatedButton(
                                            child: const Text('Close'),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                          ElevatedButton(
                                            child: const Text('Cancel'),
                                            onPressed: () async {
                                              String? result = await _confirmDelete(context);
                                              if (result == 'Yes') {
                                                Reservation.cancelRes(entry.key);
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ItemWidget(reservation: entry.value),
              ))
                  .toList(),
            ),
          );
        }
      },
    );
  }


}

class ItemWidget extends StatelessWidget {
  final Map<String, dynamic> reservation;

  const ItemWidget({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Card(
        color: const Color.fromRGBO(248, 249, 255, 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SizedBox(
            height: 60,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation['club_name'],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reservation['court_name'],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: VerticalDivider(
                    color: Colors.black26,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('dd-MM-yyyy').format(reservation['start_time']),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${DateFormat('HH:mm').format(reservation['start_time'])} - ${DateFormat('HH:mm').format(reservation['end_time'])}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String?> _confirmDelete(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancel Reservation'),
        content: const Text('Are you sure you want to delete this reservation?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop('No');
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop('Yes');
            },
          ),
        ],
      );
    },
  );
}
