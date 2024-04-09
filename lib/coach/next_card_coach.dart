// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';


class Card2_Coach extends StatelessWidget {
  const Card2_Coach({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Card(
              color: Color.fromRGBO(141, 182, 219, 1),
              child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Athletes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Card(
                    color: Color.fromRGBO(141, 182, 219, 1),
                    child: SizedBox(
                      child: Center(child: Text(
                        'Attendance: 1/5 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Card(
                    color: Color.fromRGBO(141, 182, 219, 1),
                    child: SizedBox(
                      child: Center(child: Text(
                        'Time Remaining:\n120 minutes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),),
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Card()
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
