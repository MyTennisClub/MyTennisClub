import 'package:flutter/material.dart';
import 'success_page.dart';
import 'available_hours.dart';
import 'details_section.dart';
import 'equipment_section.dart';
import 'duration_section.dart';
import 'date_section.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  // Ported from org.threeten.bp;
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

class BookCourt_Main extends StatefulWidget {
  const BookCourt_Main({super.key});

  @override
  State<BookCourt_Main> createState() => BookCourt();
}

class BookCourt extends State<BookCourt_Main> {
  bool numberCheck = true;
  bool durationCheck = true;
  bool equipmentCheck = false;
  List<bool> hourCheck = [false, false, false];
  List<bool> visible = [false, false, false];

  int number = 1;
  String cost = '10';
  String? duration = '1:00 h';
  String? date = DateFormat.yMd().format(DateTime.now());
  final List<String> courts = <String>['A', 'B', 'C'];

  String? endhour;
  String? hour;
  String? court = '';

  checkVisible() {
    setState(() {
      for (var key = 0; key < courts.length; key++) {
        if (hourCheck[key] && durationCheck && numberCheck) {
          visible[key] = true;
          calcuateDuration(hour, duration);
          court = 'Court ${courts[key]}';
        } else {
          visible[key] = false;
        }
      }
    });
  }

  checkHour(check, key, h) {
    setState(() {
      hourCheck[key] = check;
      hour = h;

      for (var i = 0; i < hourCheck.length; i++) {
        if (i != key) hourCheck[i] = false;
      }

      checkVisible();
    });
  }

  getDate(dat) {
    setState(() {
      date = dat;
    });
  }

  checkDuration(check, dur) {
    setState(() {
      durationCheck = check;
      duration = dur;

      checkVisible();
    });
  }

  checkNumber(check, numb) {
    setState(() {
      numberCheck = check;
      number = numb;

      checkVisible();
    });
  }

  checkEquipment(check) {
    setState(() {
      equipmentCheck = check;
      calculateCost();
    });
  }

  calculateCost() {
    setState(() {
      if (equipmentCheck) {
        cost = '15';
      } else {
        cost = '10';
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
          backgroundColor: const Color.fromRGBO(248, 249, 248, 1),
          title: const Row(
            children: [
              Text('Book Court',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
            ],
          ),
        ),
        body: LayoutBuilder(builder: (context, contraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: contraints.maxHeight),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Equipment_Section(
                        checkEquipment: checkEquipment,
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
                      child: Duration_Section(
                        checkDuration: checkDuration,
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
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: courts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card.outlined(
                                key: ObjectKey(
                                  courts[index],
                                ), // Using the item's value as the key.
                                color: const Color.fromRGBO(244, 246, 251, 1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Court ${courts[index]}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Hard | Covered',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              '10€',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                              checkHour: checkHour, id: index),
                                          equipmentCheck
                                              ? const Text(
                                                  textAlign: TextAlign.center,
                                                  'Additional Cost For Equipment 5€',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          29, 27, 32, 0.7)))
                                              : Container(),
                                          visible[index]
                                              ? FilledButton(
                                                  style: FilledButton.styleFrom(
                                                      backgroundColor:
                                                          const Color.fromRGBO(
                                                              0, 83, 135, 1)
                                                      // This is what you need!
                                                      ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            Success_Main(
                                                          date: date,
                                                          duration: duration,
                                                          hour: hour,
                                                          court: court,
                                                          endhour: endhour,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text('Book $cost€'),
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
