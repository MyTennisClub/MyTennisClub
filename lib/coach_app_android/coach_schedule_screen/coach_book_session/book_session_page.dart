import 'package:flutter/material.dart';
import '../../../models/court.dart';
import 'success_page.dart';
import 'available_hours.dart';
import 'details_section.dart';
import 'payment_section.dart';
import 'duration_section.dart';
import 'date_section.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = hour * 60 + minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        if (newHour >= 12) newHour += 12;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}

class BookSession_Main extends StatefulWidget {
  const BookSession_Main({super.key});

  @override
  State<BookSession_Main> createState() => BookSession();
}

class BookSession extends State<BookSession_Main> {
  bool numberCheck = true;
  bool paymentCheck = true;
  bool durationCheck = true;
  List<bool> hourCheck = [];
  List<bool> visible = [];
  late List<Map<String, dynamic>> athletesList = [];
  late Map<int, Map<String, dynamic>> availableCourts = {};
  int number = 1;
  double payment = 5;
  String? duration = '1:00 h';
  late DateTime date;
  String? hour;
  String? endhour;
  String? court = '';
  List<Map<String, dynamic>> selectedAthletes = [];
  bool _futureExec = true;

  Future<void> getFirstDate() async {
    DateTime innerDate = DateTime.now();
    bool found = false;
    while (!found) {
      Map<int, Map<String, dynamic>> availableCourts =
          await Court.fetchCourtsAndHours(
              2, innerDate, duration!, '1', number, '');

      if (availableCourts.isNotEmpty) {
        found = true;
        date = innerDate;
        break;
      } else {
        innerDate.add(const Duration(days: 1));
      }
    }
  }

  Future<void> fetchCourtsAndHours() async {
    List<int> athleteIds = [];
    String idsString = '';
    if (selectedAthletes.isNotEmpty) {
      selectedAthletes.forEach((athlete) {
        athleteIds.add(athlete['user_id']);
      });
      idsString = athleteIds.join(', ');
    }
    print('--------selected athletes--------');
    print(idsString);

    availableCourts = await Court.fetchCourtsAndHours(
        2, DateTime.now(), duration!, '1', number, idsString);
    _futureExec = false;
    hourCheck = List.filled(availableCourts.length, false);
    visible = List.filled(availableCourts.length, false);
  }

  @override
  void initState() {
    date = DateTime.now();
    // hourCheck = List.filled(availableCourts.length, false);
    //visible = List.filled(availableCourts.length, false);
    super.initState();
  }

  checkHour(check, key, h) {
    setState(() {
      hourCheck[key] = check;
      hour = h;

      for (var i = 0; i < hourCheck.length; i++) {
        if (i != key) hourCheck[i] = false;
      }

      print('$check - $key - $h');
      checkVisible();
    });
  }

  getDate(dat) {
    setState(() {
      _futureExec = true;
      visible = List.filled(availableCourts.length, false);
      hourCheck = List.filled(availableCourts.length, false);
      date = dat;
      date = date.add(
          Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute));
      print(date);
    });
  }

  checkDuration(check, dur) {
    setState(() {
      _futureExec = true;
      visible = List.filled(availableCourts.length, false);
      hourCheck = List.filled(availableCourts.length, false);
      durationCheck = check;
      duration = dur;
      checkVisible();
    });
  }

  checkNumber(check, numb) {
    setState(() {
      _futureExec = true;
      visible = List.filled(availableCourts.length, false);
      hourCheck = List.filled(availableCourts.length, false);
      numberCheck = check;
      number = numb;
      checkVisible();
    });
  }

  checkAthletes(list) {
    setState(() {
      _futureExec = true;
      visible = List.filled(availableCourts.length, false);
      hourCheck = List.filled(availableCourts.length, false);
      selectedAthletes = list;

      print(
          'printing from checkAthlete:${selectedAthletes.length}\n-----Done Printing-----');
      checkVisible();
    });
  }

  checkPayment(check, pay) {
    setState(() {
      _futureExec = true;
      paymentCheck = check;
      payment = pay;
      checkVisible();
    });
  }

  checkVisible() {
    setState(() {
      for (var key = 0; key < availableCourts.length; key++) {
        if (hourCheck[key] && durationCheck && numberCheck && paymentCheck) {
          visible[key] = true;
          court = 'Court ${availableCourts[key]}';
          calcuateDuration(hour, duration);
        } else {
          visible[key] = false;
        }
      }
    });
  }

  calcuateDuration(hour, duration) {
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(hour.split(":")[0]),
        minute: int.parse(hour.split(":")[1]));

    List<String> durationValues = duration.split(':');
    int dur = int.parse(durationValues[0]) * 60 +
        int.parse(durationValues[1].substring(0, durationValues[1].length - 1));

    endhour = startTime.plusMinutes(dur).format(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(248, 249, 255, 1),
          title: const Row(
            children: [
              Text('Book Private Session',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
            ],
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Details_Section(
                        checkNumber: checkNumber,
                        checkAthletes: checkAthletes,
                        constraints: constraints.maxHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Payment_Section(
                        checkPayment: checkPayment,
                      ),
                    ),
                    const Divider(
                      color: Color.fromRGBO(193, 199, 209, 1),
                    ),
                    const Row(
                      children: [
                        Text(
                          'Select Duration',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Duration_Section(
                          checkDuration: checkDuration,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromRGBO(193, 199, 209, 1),
                    ),
                    const Row(
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Date_Section(
                        initialDate: date,
                        getDate: getDate,
                      ),
                    ),
                    const Divider(
                      color: Color.fromRGBO(193, 199, 209, 1),
                    ),
                    const Row(
                      children: [
                        Text(
                          'Available Courts',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                        ),
                      ],
                    ),
                    FutureBuilder<void>(
                      future:
                          _futureExec == true ? fetchCourtsAndHours() : null,
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.5, // Adjust the width as needed
                            height: MediaQuery.of(context).size.height *
                                0.3, // Adjust the height as needed
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          // Print the map
                          // print("Courts and their available time slots:");
                          availableCourts.forEach((courtId, courtData) {
                            // print(
                            //     "Court ID: ${courtData['court_id']}, Court Title: ${courtData['court_title']}");
                            List timeSlots = courtData['time_slots'];
                            for (var slot in timeSlots) {
                              // print(
                              //     "  Start Time: ${slot['start_time']}, End Time: ${slot['end_time']}");
                            }
                          });

                          return availableCourts.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: availableCourts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    int courtId =
                                        availableCourts.keys.elementAt(index);
                                    Map<String, dynamic> courtData =
                                        availableCourts[courtId]!;
                                    List<DateTime> startTimes =
                                        courtData['time_slots']
                                            .map<DateTime>((slot) {
                                      String timeString =
                                          slot['start_time'].toString();
                                      List<String> parts =
                                          timeString.split(':');
                                      int hours = int.parse(parts[0]);
                                      int minutes = int.parse(parts[1]);
                                      int seconds =
                                          double.parse(parts[2]).floor();

                                      return DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        hours,
                                        minutes,
                                        seconds,
                                      );
                                    }).toList();
                                    return Card.outlined(
                                      key: ObjectKey(
                                        courtData,
                                      ),
                                      color: const Color.fromRGBO(
                                          244, 246, 251, 1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Court: ${courtData['court_title']}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  const Text(
                                                    'Hard | Covered',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Row(
                                              children: [
                                                Text(
                                                  'Available Hours',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        29, 27, 32, 0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Available_Hours(
                                                  checkHour: checkHour,
                                                  id: index,
                                                  isVisible: visible[index],
                                                  availableHours: startTimes,
                                                ),
                                                visible[index]
                                                    ? FilledButton(
                                                        style: FilledButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    const Color
                                                                        .fromRGBO(
                                                                        0,
                                                                        83,
                                                                        135,
                                                                        1)),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  Success_Main(
                                                                date: DateFormat
                                                                        .yMMMMd()
                                                                    .format(
                                                                        date),
                                                                duration:
                                                                    duration,
                                                                hour: hour,
                                                                court: court,
                                                                endhour:
                                                                    endhour,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            'Book Session'),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 100),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          'There are no available courts',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          'Please change your requirements',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
