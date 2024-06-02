import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../../../Database/ConnectionDatabase.dart';
import '../../../models/athlete.dart';
import '../../../models/member.dart';
import 'select_athletes.dart';

class Details_Section extends StatefulWidget {
  final Function checkNumber;
  final Function checkAthletes;
  final double constraints;

  const Details_Section(
      {required this.checkNumber,
      required this.checkAthletes,
      required this.constraints,
      super.key});

  @override
  State<Details_Section> createState() => DetailsSection();
}

class DetailsSection extends State<Details_Section> {
  late TextEditingController _controller;
  bool numberCheck = true;
  int number = 1;
  int allowedMemberNumber = 0;
  List<Map<String, dynamic>> selectedAthletes = [];
  late List<Map<String, dynamic>> athletesList = [];

  String _errorText = ('');

  Future<void> _fetchAllowedMemberNumber() async {
    final conn = await MySQLConnector.createConnection();
    var result = await conn!.query('CALL GetMaxPeopleCourtByClub(2)');

    allowedMemberNumber = result.first['max_people_court'];

    await conn.close();
    setState(() {});
  }

  Future<void> fetchAndDisplayAthletes() async {
    athletesList = await Athletes.fetchAthletesFromClub(2);
    // Display the fetched athletes
    athletesList.forEach((athlete) {
      print('User ID: ${athlete['user_id']}');
      print('First Name: ${athlete['user_first_name']}');
      print('Last Name: ${athlete['user_last_name']}');
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '1');
    _fetchAllowedMemberNumber();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openSelectAthletes(BuildContext context) {
    return showModalBottomSheet<void>(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<void>(
          future: selectedAthletes.isEmpty ? fetchAndDisplayAthletes() : null,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // You can show a loading indicator while waiting for the future
            } else {
              return SizedBox(
                height: widget.constraints,
                child: Select_Athletes(
                  number: number,
                  selectedAthletes: selectedAthletes,
                  athletesList: athletesList,
                  checkAthletes: widget.checkAthletes,
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.group_outlined),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    numberCheck = false;
                    number = 0;
                  } else if (int.parse(value) == 0) {
                    numberCheck = false;
                    _errorText = "Number can't be zero";
                    number = 0;
                  } else if (int.parse(value) > allowedMemberNumber) {
                    _errorText =
                        'Must be less than ${allowedMemberNumber.toString()}';
                    numberCheck = false;
                    number = 0;
                  } else {
                    _errorText = '';
                    numberCheck = true;
                    number = int.parse(value);
                  }
                  selectedAthletes = [];
                  widget.checkNumber(numberCheck, number);
                  widget.checkAthletes(selectedAthletes);
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter number',
                  border: const OutlineInputBorder(),
                  labelText: 'Number of Athletes',
                  errorText: _errorText.isEmpty ? null : _errorText),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: _controller,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Color.fromRGBO(0, 83, 135, 1),
                    size: 22,
                  ),
                ),
                TextSpan(
                  text: 'Select Athletes',
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 83, 135, 1), fontSize: 14),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (numberCheck) {
                        (_openSelectAthletes(context));
                        widget.checkAthletes(selectedAthletes);
                      }
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
