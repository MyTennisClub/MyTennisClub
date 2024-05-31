import 'package:flutter/material.dart';
import '../../../models/court.dart';
import '../../../models/member.dart';
import 'success_page.dart';
import 'available_hours.dart';
import 'details_section.dart';
import 'payment_section.dart';
import 'duration_section.dart';
import 'date_section.dart';
import 'package:intl/intl.dart';
import 'package:mytennisclub/data/pbc_data.dart';

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
  late List<Member> membersList;
  late List<Court> courtsList;
  List<Court> availableCourts = [];
  Map<Court, List<DateTime>> courtsAndHours = {};

  @override
  void initState() {
    membersList = createMembers();
    courtsList = createCourts();
    createReservations(membersList, courtsList);

    hourCheck = List.filled(courtsList.length, false);
    visible = List.filled(courtsList.length, false);

    DateTime firstDate = getFirstAvailableDate(courtsList);
    date = firstDate;

    populateCourts(courtsList, firstDate, duration!, number);

    super.initState();
  }

  void populateCourts(
    List<Court> courts,
    DateTime date,
    String duration,
    int numAthletes,
  ) {
    availableCourts = [];
    for (var i = 0; i < courts.length; i++) {
      List<DateTime> availableHours = [];
      if (courts[i].athlete_capacity >= numAthletes) {
        availableHours = getAvailableHoursForCourt(courts[i], date, duration);
        if (availableHours.isNotEmpty) {
          availableCourts.add(courts[i]);
          courtsAndHours[courts[i]] = availableHours;
          if (i == 0) {
            print(courtsAndHours[availableCourts[i]]);
          }
        }
      }
    }
  }

  int number = 1;
  double payment = 5;
  //final List<String> courts = <String>['A', 'B', 'C', 'D'];
  String? duration = '1:00 h';
  late DateTime date;

  String? hour;
  String? endhour;
  String? court = '';
  List<String> athletes = [];

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
      date = dat;
      date = date.add(
          Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute));
      print(date);
      populateCourts(courtsList, date, duration!, number);
    });
  }

  checkDuration(check, dur) {
    setState(() {
      durationCheck = check;
      duration = dur;
      populateCourts(courtsList, date, duration!, number);
      checkVisible();
    });
  }

  checkNumber(check, numb) {
    setState(() {
      numberCheck = check;
      number = numb;
      populateCourts(courtsList, date, duration!, number);
      checkVisible();
    });
  }

  checkAthletes(list) {
    setState(() {
      athletes = list;
      print(athletes);

      checkVisible();
    });
  }

  checkPayment(check, pay) {
    setState(() {
      paymentCheck = check;
      payment = pay;
      populateCourts(courtsList, date, duration!, number);
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
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        availableCourts.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: availableCourts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card.outlined(
                                      key: ObjectKey(
                                        availableCourts[index],
                                      ), // Using the item's value as the key.
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
                                                    'Court: ${availableCourts[index].name}',
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
                                                  availableHours:
                                                      courtsAndHours[
                                                          availableCourts[
                                                              index]]!,
                                                ),
                                                visible[index]
                                                    ? FilledButton(
                                                        style: FilledButton.styleFrom(
                                                            backgroundColor:
                                                                const Color
                                                                    .fromRGBO(0,
                                                                    83, 135, 1)
                                                            // This is what you need!
                                                            ),
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
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 100),
                                  // Set background color to blue
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          'There are no available courts',
                                          style: TextStyle(
                                            fontWeight: FontWeight
                                                .w400, // Make the text bold
                                            fontSize:
                                                20, // Optional: adjust font size as needed
                                            // Optional: change text color to white for better visibility
                                          ),
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          'Please change your requirements',
                                          style: TextStyle(
                                            fontWeight: FontWeight
                                                .normal, // Make the text bold
                                            fontSize:
                                                16, // Optional: adjust font size as needed
                                            // Optional: change text color to white for better visibility
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
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
