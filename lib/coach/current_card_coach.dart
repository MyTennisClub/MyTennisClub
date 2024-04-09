import 'package:flutter/material.dart';

class Card1_Coach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(
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
                        'Attendance: 3/5 ',
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
                        'Time Remaining:\n45 minutes',
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
