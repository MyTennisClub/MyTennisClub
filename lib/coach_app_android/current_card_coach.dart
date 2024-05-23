import 'package:flutter/material.dart';

class Card1_Coach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Card(
          color: Color.fromRGBO(141, 182, 219, 1),
          child: SizedBox(
              width: 160,
              height: 110,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Athletes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
                ),
              )),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Card(
                color: Color.fromRGBO(141, 182, 219, 1),
                child: SizedBox(
                  width: 155,
                  height: 35,
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
              Card(
                color: Color.fromRGBO(141, 182, 219, 1),
                child: SizedBox(
                  width: 155,
                  height: 65,
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
            ],
          ),
        )
      ],
    );
  }
}
