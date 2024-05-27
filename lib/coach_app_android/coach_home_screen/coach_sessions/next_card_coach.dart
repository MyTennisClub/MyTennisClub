import 'package:flutter/material.dart';


class Card2_Coach extends StatelessWidget {
  const Card2_Coach({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Card(
          color: Color.fromRGBO(141, 182, 219, 1),
          child: SizedBox(
              width: 160,
              height: 110,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
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
          child: const Column(
            children: <Widget>[
              Card(
                color: Color.fromRGBO(141, 182, 219, 1),
                child: SizedBox(
                  width: 155,
                  height: 35,
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
              Card(
                color: Color.fromRGBO(141, 182, 219, 1),
                child: SizedBox(
                  width: 155,
                  height: 65,
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
            ],
          ),
        )
      ],
    );
  }
}
