import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Reservation.dart';

class UpcomingReservations extends StatefulWidget {
  final List<Reservation> reservations;

  const UpcomingReservations({super.key, required this.reservations});

  @override
  _UpcomingReservationsState createState() => _UpcomingReservationsState();
}

class _UpcomingReservationsState extends State<UpcomingReservations> {
  late List<Reservation> _reservations;

  @override
  void initState() {
    super.initState();
    _filterUpcomingReservations();
  }

  void _filterUpcomingReservations() {
    DateTime now = DateTime.now();
    _reservations = widget.reservations
        .where((reservation) => reservation.startTime.isAfter(now))
        .toList();
  }

  void _deleteReservation(int id) {
    setState(() {
      _reservations.removeWhere((reservation) => reservation.id == id);
    });
  }

  // Future<void> _showDeleteConfirmationDialog(BuildContext context, int id) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Delete Reservation'),
  //         content: const Text('Are you sure you want to delete this reservation?'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Yes'),
  //             onPressed: () {
  //               _deleteReservation(id);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {

      return _reservations.isNotEmpty
          ? SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _reservations
              .map((reservation) => GestureDetector(
            onTap: () {
              // Handle item click here
              // _deleteReservation(reservation.id);
              // print(reservation.qrCode.hashCode.toString());
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 0.9,
                    child: Container(
                      // color: Colors.red,
                      child: LayoutBuilder(
                        builder: (BuildContext context,
                            BoxConstraints constraints) {
                          double modalHeight = constraints
                              .maxHeight; // This will give you the height of the modal bottom sheet
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
                                    style:
                                    TextStyle(fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: modalHeight -
                                      modalHeight / 3,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(reservation.title),
                                        Text(DateFormat(
                                            'dd-MM-yyyy')
                                            .format(reservation
                                            .startTime)),
                                        Text('${DateFormat('HH:mm').format(reservation.startTime)} - ${DateFormat('HH:mm').format(reservation.endTime)}'),
                                        reservation.qrCode,

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
                                        child:
                                        const Text('Close'),
                                        onPressed: () =>
                                            Navigator.pop(
                                                context),
                                      ),
                                      ElevatedButton(
                                        child:
                                        const Text('Cancel'),
                                        onPressed: () async {
                                          String? result = await _confirmDelete(context);
                                          if(result == 'Yes'){
                                            _deleteReservation(reservation.id);
                                            Navigator.pop(context);
                                          }
                                          // print(result);
                                          // Navigator.pop(context);
                                          // _deleteReservation(reservation.id);
                                        },
                                      )
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
      )
          : Container(
          child: const Align(
              alignment: Alignment.center,
              child: Text('No Sessions For Today')));
    });
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
                )
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
