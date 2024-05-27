import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'current_card_coach.dart';
import 'next_card_coach.dart';
class SessionsCoach extends StatefulWidget {
  const SessionsCoach({super.key});

  @override
  State<SessionsCoach> createState() => _SessionsCoachState();
}

class _SessionsCoachState extends State<SessionsCoach> {
  bool currentIsPressed = true;
  bool nextIsPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        currentIsPressed = true;
                        nextIsPressed = false;
                      })
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          currentIsPressed ? const Color(0xffff3c70a0) : Colors.grey,
                    ),
                    child: const Text(
                      'Current',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        currentIsPressed = false;
                        nextIsPressed = true;
                      })
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          nextIsPressed ? const Color(0xffff3c70a0) : Colors.grey,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: currentIsPressed ? const Card1_Coach():const Card2_Coach()),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffff3c70a0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Attendance Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffff3c70a0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Attendance Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
