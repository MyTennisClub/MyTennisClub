import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _currentDate = DateTime.now();
  final DateTime _initialDate = DateTime.now();

  // List of reservations
  List<Reservation> reservations = [
    Reservation(
      id: 1,
      title: 'ATH Tennis',
      court: 'Court A',
      startTime: DateTime.parse('2024-05-30 12:00:00'),
      endTime: DateTime.parse('2024-05-30 14  :00:00'),
    ),
    Reservation(
      id: 2,
      title: 'Patras Tennis',
      court: 'Court B',
      startTime: DateTime.parse('2024-06-01 09:00:00'),
      endTime: DateTime.parse('2024-06-01 11:00:00'),
    ),
    Reservation(
      id: 3,
      title: 'Ceid',
      court: 'Court C',
      startTime: DateTime.parse('2024-06-02 09:00:00'),
      endTime: DateTime.parse('2024-06-02 23:00:00'), // Example of upcoming reservation
    ),
    // Add more reservations here
  ];

  void _previousWeek() {
    setState(() {
      // Calculate the start of the current week
      DateTime startOfWeek =
      _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
      // Ensure we do not go before the initial week's start
      if (startOfWeek.isAfter(_initialDate.subtract(const Duration(days: 7))) &&
          startOfWeek.isAfter(_initialDate)) {
        _currentDate = _currentDate.subtract(const Duration(days: 7));
      }
    });
  }

  void _nextWeek() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 7));
    });
  }

  List<Widget> _generateWeekDays() {
    List<Widget> days = [];
    DateTime startOfWeek =
    _currentDate.subtract(Duration(days: _currentDate.weekday - 1));

    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      days.add(Expanded(
        child: Container(
          color: Colors.white,
          child: Text(
            '${day.weekday == 1 ? 'Mon\n' : day.weekday == 2 ? 'Tue\n' : day.weekday == 3 ? 'Wed\n' : day.weekday == 4 ? 'Thu\n' : day.weekday == 5 ? 'Fri\n' : day.weekday == 6 ? 'Sat\n' : 'Sun\n'} ${day.day}',
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _previousWeek,
                child: const Icon(Icons.arrow_back, size: 30),
              ),
              ..._generateWeekDays(),
              GestureDetector(
                onTap: _nextWeek,
                child: const Icon(Icons.arrow_forward, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildDayRow(
              ['Hour', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(15, (index) {
                  final int hour = index + 9; // Start from 09:00
                  return _buildHourRow(hour);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayRow(List<String> days) {
    return Row(
      children: days.map((day) {
        return Expanded(
          child: Container(
            height: 40,
            color: Colors.black26,
            child: Center(
              child: Text(
                day,
                style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHourRow(int hour) {
    DateTime startOfWeek =
    _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
    return Row(
      children: [
        Container(
          color: Colors.white,
          height: 40,
          width: 60,
          child: Center(
            child: Text(
              '${hour.toString().padLeft(2, '0')}:00', // Format hour to HH:00
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        ...List.generate(7, (dayIndex) {
          DateTime day = startOfWeek.add(Duration(days: dayIndex));
          String reservationTitle = _getReservationForHour(day, hour);
          Color containerColor = _getReservationColor(day, hour);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (reservationTitle.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Reservation Details'),
                          content: Text(
                              'Title: $reservationTitle\nCourt: ${_getReservationCourt(reservationTitle)}\nTime: ${_formatTime(day, hour)}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ]);
                    },
                  );
                }
              },
              child: Container(
                color: containerColor,
                height: 40,
                child: Center(
                  child: Text(
                    reservationTitle,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Color _getReservationColor(DateTime day, int hour) {
    DateTime startOfHour = DateTime(day.year, day.month, day.day, hour);
    DateTime endOfHour = startOfHour.add(const Duration(hours: 1));
    for (var reservation in reservations) {
      if ((reservation.startTime.isBefore(endOfHour) &&
          reservation.endTime.isAfter(startOfHour))) {
        return Colors.blue;
      }
    }
    return Colors.grey.shade200;
  }

  String _getReservationForHour(DateTime day, int hour) {
    DateTime startOfHour = DateTime(day.year, day.month, day.day, hour);
    for (var reservation in reservations) {
      if (reservation.startTime.isAtSameMomentAs(startOfHour)) {
        return reservation.title;
      }
    }
    return '';
  }

  String _getReservationCourt(String reservationTitle) {
    for (var reservation in reservations) {
      if (reservation.title == reservationTitle) {
        return reservation.court;
      }
    }
    return '';
  }

  String _formatTime(DateTime day, int hour) {
    DateTime startOfHour = DateTime(day.year, day.month, day.day, hour);
    return '${startOfHour.hour.toString().padLeft(2, '0')}:00 - ${(startOfHour.hour + 1).toString().padLeft(2, '0')}:00';
  }
}

class Reservation {
  final int id;
  final String title;
  final String court;
  final DateTime startTime;
  final DateTime endTime;

  Reservation({
    required this.id,
    required this.title,
    required this.court,
    required this.startTime,
    required this.endTime,
  });
}