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
                    child: Text(
                      'Current',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          currentIsPressed ? Color(0xFFFF3C70A0) : Colors.grey,
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
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          nextIsPressed ? Color(0xFFFF3C70A0) : Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: currentIsPressed ? Card1_Coach():Card2_Coach()),
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
                        child: Text(
                          'Attendance Book',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF3C70A0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
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
                        child: Text(
                          'Attendance Book',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF3C70A0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
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
