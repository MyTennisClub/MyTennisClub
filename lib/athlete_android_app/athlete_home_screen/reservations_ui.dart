import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:mytennisclub/Database/ConnectionDatabase.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum ResType { private, public }

class Reservation {
  final int id;
  final String title;
  final String court;
  final DateTime startTime;
  final DateTime endTime;
  late Widget qrCode; // Variable to store the QR code
  final ResType resType;

  Reservation({
    required this.id,
    required this.title,
    required this.court,
    required this.startTime,
    required this.endTime,
    required this.resType,
  }) {
    qrCode = QrImageView(
      data: id.toString(),
      version: QrVersions.auto,
      gapless: false,
    ); // Call function to generate QR code
  }
}

class UpcomingReservations extends StatefulWidget {
  const UpcomingReservations({super.key});

  @override
  _UpcomingReservationsState createState() => _UpcomingReservationsState();
}

class _UpcomingReservationsState extends State<UpcomingReservations> {
  late Future<Map<int, Reservation>> _reservationsFuture;
  MySqlConnection? _connection;

  @override
  void initState() {
    super.initState();
    _reservationsFuture = _fetchReservationsFromDatabase();
    _databaseConnection();
  }

  Future<Map<int, Reservation>> _fetchReservationsFromDatabase() async {
    final Map<int, Reservation> reservationsMap = {};
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var results = await conn.query('SELECT * FROM reservations');
        // final result = await conn.query('SELECT * FROM users');

        //
        // for (var row in results) {
        //   print(row['res_type'].runtimeType);
        //
        // }
        for (var row in results) {
          // print(row['id']);

          var reservation = Reservation(
            id: row['id'], // Convert to integer
            title: row['title'],
            court: row['court'],
            startTime: row['start_time'],
            endTime: row['end_time'],
            resType:
                row['res_type'] == 'private' ? ResType.private : ResType.public,
          );
          reservationsMap[reservation.id] = reservation;
        }
        await conn.close();
      }
    } catch (e) {
      print('An error occurred while fetching reservations: $e');
    }
    return reservationsMap;
  }

  Future<void> _databaseConnection() async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        setState(() {
          _connection = conn;
        });
        print('Connected to database');
      } else {
        print('Failed to connect to the database');
      }
    } catch (e) {
      print('An error occurred while connecting to the database: $e');
    }
  }

  Future<void> _deleteReservation(int id) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query('DELETE FROM reservations WHERE id = ?', [id]);
        await conn.close();
      }
    } catch (e) {
      print('An error occurred while deleting reservation: $e');
    }

    setState(() {
      _reservationsFuture = _fetchReservationsFromDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, Reservation>>(
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
          final upcomingReservations = reservations.values
              .where((reservation) =>
                  reservation.startTime.isAfter(DateTime.now()))
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: upcomingReservations
                  .map((reservation) => GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return FractionallySizedBox(
                                heightFactor: 0.9,
                                child: Container(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      double modalHeight =
                                          constraints.maxHeight;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text(
                                                'Reservation Info',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  modalHeight - modalHeight / 3,
                                              child: Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(reservation.title),
                                                    Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(reservation
                                                                .startTime)),
                                                    Text(
                                                      '${DateFormat('HH:mm').format(reservation.startTime)} - ${DateFormat('HH:mm').format(reservation.endTime)}',
                                                    ),
                                                    Text("reservation.qrCode"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text('Close'),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () async {
                                                      String? result =
                                                          await _confirmDelete(
                                                              context);
                                                      if (result == 'Yes') {
                                                        _deleteReservation(
                                                            reservation.id);
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
                        child: ItemWidget(reservation: reservation),
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
  final Reservation reservation;

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation.title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reservation.court,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('dd-MM-yyyy').format(reservation.startTime),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${DateFormat('HH:mm').format(reservation.startTime)} - ${DateFormat('HH:mm').format(reservation.endTime)}',
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
        content:
            const Text('Are you sure you want to delete this reservation?'),
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
