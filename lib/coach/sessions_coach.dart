import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                        currentIsPressed ? const Color(0xFFFF3C70A0) : Colors.grey,
                      ),
                      child: const Text(
                        'Current',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () => {
                        setState(() {
                          currentIsPressed = false;
                          nextIsPressed = true;
                        })
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        nextIsPressed ? const Color(0xFFFF3C70A0) : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: currentIsPressed ? Card1_Coach():const Card2_Coach(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Card(
                  child: SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text(
                        'Attendance Book',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3C70A0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text(
                        'Training Program',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3C70A0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}