import 'package:flutter/material.dart';

class LatestAnnouncement extends StatelessWidget {
  const LatestAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 4;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget> [
        Card(
          color: Color.fromRGBO(141, 182, 219, 1),
          child: SizedBox(
              height: 70,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
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
                    // Text('On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and...', style: TextStyle(color: Colors.white),)
                  ],
                ),
              )),
        ),
        ],
      ),
    );
  }
}
