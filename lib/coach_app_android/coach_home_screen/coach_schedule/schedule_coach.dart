import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodayScheduleCoach extends StatelessWidget {
  const TodayScheduleCoach({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 20;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
                items, (index) => ItemWidget(text: 'Item $index')),
          ),
        ),
      );
    });
  }
}


class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Color.fromRGBO(141, 182, 219, 1),
        child: SizedBox(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical:3.5),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.saceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.schedule,
                        size: 18.0,
                      ),
                      Text(
                          '12:00 - 13:00',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, )

                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                  child: Text(
                      'Group A Session',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                // VerticalDivider(
                //   color: Colors.white,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                  child: Text(
                      'Court A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ],
            )),
      ),
    );
  }
}