import 'package:flutter/material.dart';

class TodayScheduleCoach extends StatelessWidget {
  const TodayScheduleCoach({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 2;
    return LayoutBuilder(builder: (context, constraints) {
      return items > 0 ?SingleChildScrollView(
        child: Container(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
                items, (index) => ItemWidget(text: 'Item $index')),
          ) ,
        ),
      ): Container(child: Align(alignment: Alignment.center, child: Text('No Sessions For Today')));
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
    final _widthBox = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
      child: Card(
        color: const Color.fromRGBO(248, 249, 255, 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
              height: 60,
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Group A Session',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        Text(
                            'Court A',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const VerticalDivider(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical:10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                          size: 18.0,
                        ),
                        Text(
                            '12:00 - 13:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}