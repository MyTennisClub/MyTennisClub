import 'package:flutter/material.dart';
import 'current_card_coach.dart';
import 'next_card_coach.dart';


enum Choices {Current, Next}


class SessionsCoach extends StatefulWidget {
  const SessionsCoach({super.key});

  @override
  State<SessionsCoach> createState() => _SessionsCoachState();
}

class _SessionsCoachState extends State<SessionsCoach> {

  Choices _choice = Choices.Current;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
            child: SegmentedButton<Choices>(
              segments: const <ButtonSegment<Choices>>[
                ButtonSegment<Choices>(
                  value: Choices.Current,
                  label: Text(
                      'Current',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  // icon: Icon(Icons.calendar_view_day)),
                ),
                ButtonSegment<Choices>(
                  value: Choices.Next,
                  label: Text(
                      'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                )
              ],
              selected: <Choices>{_choice},
              onSelectionChanged: (Set<Choices> newSelection) {
                setState(() {
                  _choice = newSelection.first;

                });
              },
            ),
        ),
        Expanded(
          child: _choice == Choices.Current ? const CurrentCard() : const NextCard(),
        )
      ],
    );
  }
}




