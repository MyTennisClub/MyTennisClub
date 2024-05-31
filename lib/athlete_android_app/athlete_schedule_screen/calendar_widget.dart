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

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Future<Map<int, Reservation>> _reservationsFuture;
  MySqlConnection? _connection;
  Map<int, Reservation> _reservations = {};

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
        for (var row in results) {
          var reservation = Reservation(
            id: row['id'], // Convert to integer
            title: row['title'],
            court: row['court'],
            startTime:row['start_time'],
            endTime: row['end_time'],
            resType: row['res_type'] == 'private' ? ResType.private : ResType.public,
          );
          reservationsMap[reservation.id] = reservation;
        }
        await conn.close();
      }
    } catch (e) {
      print('An error occurred while fetching reservations: $e');
    }
    setState(() {
      _reservations = reservationsMap;
    });
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

  DateTime _currentDate = DateTime.now();
  final DateTime _initialDate = DateTime.now();
  final PageController _pageController = PageController(initialPage: 0);

  void _onPageChanged(int index) {
    setState(() {
      _currentDate = _initialDate.add(Duration(days: 7 * index));
    });
  }

  List<Widget> _generateWeekDays(DateTime date) {
    List<Widget> days = [];
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    days.add(Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          DateFormat.MMM().format(date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
    ));

    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      bool isCurrentDate = DateUtils.isSameDay(day, DateTime.now());
      days.add(Expanded(
        child: Container(
          decoration: isCurrentDate
              ? BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${day.day}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              Text(DateFormat.E().format(day)),
            ],
          ),
        ),
      ));
    }

    return days;
  }

  Widget _buildPage(DateTime date) {
    return Column(
      children: [
        Row(children: _generateWeekDays(date)),
        const SizedBox(height: 5),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(15, (index) {
                final int hour = index + 9; // Start from 09:00
                return _buildHourRow(date, hour);
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourRow(DateTime date, int hour) {
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black))),
              height: 80,
              width: 50,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${hour == 12 ? 12 : hour % 12}\n',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: hour < 12 ? 'AM' : 'PM',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: List.generate(7, (dayIndex) {
                  DateTime day = startOfWeek.add(Duration(days: dayIndex));
                  Map<String, dynamic> reservationInfo =
                  _getReservationInfo(day, hour);
                  Color containerColor = reservationInfo['color'];
                  bool checkFirst = checkBorder(
                      reservationInfo['color'], reservationInfo['firstBox']);

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (containerColor != Colors.white &&
                            reservationInfo['type'] != ResType.private) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Reservation Details'),
                                content: Text('Inform of absence to be continued'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Column(
                        children: reservationInfo['start'] == 'start'
                            ? [
                          Container(
                            decoration: BoxDecoration(
                              color: containerColor,
                              border: Border(
                                top: BorderSide(
                                    color: checkFirst == true
                                        ? Colors.black
                                        : containerColor),
                              ),
                            ),
                            height: 80,
                            child: Center(
                              child: Text(
                                checkFirst == true
                                    ? reservationInfo['title']
                                    : '',
                                style: TextStyle(
                                    color: containerColor == Colors.white
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]
                            : [
                          Container(
                            decoration: BoxDecoration(
                              color: checkFirst == true
                                  ? Colors.white
                                  : containerColor,
                              border: Border(
                                top: BorderSide(
                                    color: checkFirst == true
                                        ? Colors.black
                                        : containerColor),
                              ),
                            ),
                            height: 40,
                            child: const Center(
                              child: Text(''),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: reservationInfo['end'] == 'half'
                                  ? Colors.white
                                  : containerColor,
                            ),
                            height: 40,
                            child: Center(
                              child: Text(
                                checkFirst == true
                                    ? reservationInfo['title']
                                    : '',
                                style: TextStyle(
                                    color: containerColor == Colors.white
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool checkBorder(Color color, bool firstBox) {
    return color == Colors.white || firstBox;
  }

  Map<String, dynamic> _getReservationInfo(DateTime day, int hour) {
    DateTime startOfHour = DateTime(day.year, day.month, day.day, hour);
    DateTime halfHour = startOfHour.add(const Duration(minutes: 30));
    DateTime endOfHour = startOfHour.add(const Duration(hours: 1));
    Color color = Colors.white;
    bool firstBox = false;
    bool lastBox = false;
    String title = '';
    ResType type = ResType.public;
    String start = '';
    String end = '';
    String court = '';

    for (var reservation in _reservations.values) {
      if (reservation.startTime.isBefore(endOfHour) &&
          reservation.endTime.isAfter(startOfHour)) {
        title = reservation.title;
        type = reservation.resType;
        court = reservation.court;

        if (reservation.startTime.isAtSameMomentAs(startOfHour)) {
          firstBox = true;
          start = 'start';
        } else if (reservation.startTime.isAtSameMomentAs(halfHour)) {
          firstBox = true;
          start = 'half';
        }

        if (reservation.endTime.isAtSameMomentAs(endOfHour)) {
          end = 'end';
        } else if (reservation.endTime.isAtSameMomentAs(halfHour)) {
          end = 'half';
        }

        if ((reservation.startTime.isBefore(halfHour) &&
            reservation.endTime.isAfter(startOfHour)) ||
            (reservation.startTime.isBefore(endOfHour) &&
                reservation.endTime.isAfter(halfHour)) ||
            (reservation.endTime.hour == hour &&
                reservation.endTime.minute == 30)) {
          if (reservation.resType == ResType.public) {
            color = const Color.fromRGBO(0, 83, 135, 1);
          } else {
            color = const Color.fromRGBO(0, 83, 120, 50);
            title = 'Private Session';
          }
        }

        return {
          'title': title,
          'color': color,
          'court': court,
          'type': type,
          'start': start,
          'end': end,
          'firstBox': firstBox,
        };
      }
    }

    return {
      'title': title,
      'color': color,
      'court': court,
      'type': type,
      'start': start,
      'end': end,
      'firstBox': firstBox,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map<int, Reservation>>(
              future: _reservationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  _reservations = snapshot.data ?? {};
                  return PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (index < 0) {
                        _pageController.jumpToPage(0);
                      } else {
                        _onPageChanged(index);
                      }
                    },
                    itemBuilder: (context, index) {
                      DateTime date = _initialDate.add(Duration(days: 7 * index));
                      if (date.isBefore(_initialDate.subtract(Duration(days: _initialDate.weekday - 1)))) {
                        return Container(); // Return an empty container if trying to navigate to a previous week
                      }
                      return _buildPage(date);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
