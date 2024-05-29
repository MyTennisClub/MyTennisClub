import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QR_Info extends StatefulWidget {
  final Map<String, dynamic> results;
  final Function clearResult;
  const QR_Info({super.key, required this.clearResult, required this.results});

  @override
  State<QR_Info> createState() => QRInfo();
}

class QRInfo extends State<QR_Info> {
  late String firstName;
  late String lastName;
  late int people = 4;
  late String equipment;
  late String court;
  late String resDate;
  late String startTime;
  late String endTime;

  String printEquipment(equipment) {
    List<String> equipmentList = equipment.split(',');
    String print = '';
    for (var i = 0; i < equipmentList.length; i++) {
      print += equipmentList[i];
      if (i != equipmentList.length - 1) {
        print += '\n';
      }
    }
    return print;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    firstName = 'First Name'; // Default value or fetch from another source
    lastName = 'Last Name'; // Default value or fetch from another source
    people = 4; // Default value or fetch from another source
    equipment =
        'Rackets,Balls,Wristbands'; // Default value or fetch from another source
    court = widget.results['court'] ?? 'Unknown Court';

    // Ensure start_time and end_time are parsed correctly
    DateTime startTimeDate = widget.results['start_time'] is String
        ? DateTime.parse(widget.results['start_time'])
        : widget.results['start_time'];
    DateTime endTimeDate = widget.results['end_time'] is String
        ? DateTime.parse(widget.results['end_time'])
        : widget.results['end_time'];

    resDate = DateFormat.yMd().format(startTimeDate);
    startTime = DateFormat.Hm().format(startTimeDate);
    endTime = DateFormat.Hm().format(endTimeDate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(236, 238, 243, 1),
          title: const Text('QR Info',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 21)),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card.outlined(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text('First Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Expanded(child: Text(firstName)),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text('Last Name',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Expanded(
                                          child: Text(
                                        lastName,
                                      )),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text('People',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Expanded(child: Text(people.toString())),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text('Equipment',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Expanded(
                                          child:
                                              Text(printEquipment(equipment))),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text('Court',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Expanded(child: Text(court)),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        child: Text('Res. Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Expanded(child: Text(resDate)),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Expanded(
                                      child: Text('Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Expanded(
                                        child: Text('$startTime - $endTime')),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 83, 135, 1)
                          // This is what you need!
                          ),
                      onPressed: () {
                        widget.clearResult('');
                        Navigator.pop(context); // Close the screen
                      },
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
