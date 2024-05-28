import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
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
  int allowedMemberNumber = 4;
  List<String> athletes = [];

  String _errorText = ('');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openSelectAthletes(BuildContext context) {
    return showModalBottomSheet<List<String>>(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: widget.constraints,
              child: Select_Athletes(
                number: number,
                athletes: athletes,
              ));
        });
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
                  athletes = [];
                  widget.checkNumber(numberCheck, number);
                  widget.checkAthletes(athletes);
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
                        widget.checkAthletes(athletes);
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
