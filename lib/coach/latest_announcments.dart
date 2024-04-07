import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LatestAnnouncement extends StatelessWidget {
  const LatestAnnouncement({super.key});

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
            height: 70,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Title',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                  Expanded(child: Text('On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and...', style: TextStyle(color: Colors.white),))
                ],
              ),
            )),
      ),
    );
  }
}
