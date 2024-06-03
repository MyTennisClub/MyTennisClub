import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytennisclub/models/reservation.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late Future<Map<int, dynamic>> _reservationsFuture;
  Map<int, dynamic> _reservations = {};

  @override
  void initState() {
    super.initState();
    _reservationsFuture = Reservation.getUpcomingResCalendar(1);
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
                  Map<String, dynamic> reservationInfo = _getReservationInfo(day, hour);
                  Color containerColor = reservationInfo['color'];
                  bool checkFirst = checkBorder(reservationInfo['color'], reservationInfo['firstBox']);

                  Widget container = Column(
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
                            checkFirst == true ? reservationInfo['title'] : '',
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
                            checkFirst == true ? reservationInfo['title'] : '',
                            style: TextStyle(
                                color: containerColor == Colors.white
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );

                  return reservationInfo['type'] == 'SESSION'
                      ? Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (reservationInfo['resType'] != 'RESERVATION') {
                          print('Reservation Info: $reservationInfo');
                          showReservationModal(context, reservationInfo);
                        }
                      },
                      child: container,
                    ),
                  )
                      : Expanded(child: container);
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
    String clubName = '';
    String courtName = '';
    String resType = '';
    String start = '';
    String end = '';
    int reservationId;

    for (var reservation in _reservations.values) {
      DateTime startTime = reservation['start_time'];
      DateTime endTime = reservation['end_time'];
      String resType = reservation['type'].toString();
      print(resType);
      reservationId = reservation['id'];
      if (startTime.isBefore(endOfHour) && endTime.isAfter(startOfHour)) {
        courtName = reservation['court'];
        clubName = reservation['club_name'];
        print(clubName);

        if (startTime.isAtSameMomentAs(startOfHour)) {
          firstBox = true;
          start = 'start';
        } else if (startTime.isAtSameMomentAs(halfHour)) {
          firstBox = true;
          start = 'half';
        }

        if (endTime.isAtSameMomentAs(endOfHour)) {
          end = 'end';
        } else if (endTime.isAtSameMomentAs(halfHour)) {
          end = 'half';
        }

        if ((startTime.isBefore(halfHour) && endTime.isAfter(startOfHour)) ||
            (startTime.isBefore(endOfHour) && endTime.isAfter(halfHour)) ||
            (endTime.hour == hour && endTime.minute == 30)) {
          if (resType == 'SESSION') {
            if (reservation['absence'] == 1)
              color = const Color.fromRGBO(0, 83, 135, 50);
            else
              color = const Color.fromRGBO(0, 83, 135, 1);
          } else {
            color = const Color.fromRGBO(0, 83, 120, 50);
            clubName = 'Booked';
          }
        }

        return {
          'title': clubName,
          'color': color,
          'court': courtName,
          'type': resType,
          'start': start,
          'end': end,
          'firstBox': firstBox,
        };
      }
    }

    return {
      'title': clubName,
      'color': color,
      'court': courtName,
      'type': resType,
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
            child: FutureBuilder<Map<int, dynamic>>(
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

void showReservationModal(BuildContext context, Map<String, dynamic> reservationInfo) {
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Session Info',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: modalHeight - modalHeight / 3,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(reservationInfo['title'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(reservationInfo['court'],
                                style: const TextStyle(fontSize: 18)),
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
                              String result = 'yes';
                              // String? result = await _confirmDelete(context);
                              if (result == 'Yes') {
                                // Reservation.cancelRes(entry.key);
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
}
