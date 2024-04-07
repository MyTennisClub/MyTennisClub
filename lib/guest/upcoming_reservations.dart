import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpcomingReservations extends StatelessWidget {
  const UpcomingReservations({super.key});

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
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.saceBetween,
                    children: <Widget>[
                      Text(
                        '08-04-24',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 2),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.saceBetween,
                    children: <Widget>[
                      Text(
                          'ATH Tennis',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      Text(
                          'Karaiskaki 10',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, )

                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    size: 30,
                    Icons.qr_code,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
