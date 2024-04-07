import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpacedItemsList extends StatelessWidget {
  const SpacedItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 4;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
    return const Card(
      color: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(42, 109, 108, 108),
                    minRadius: 5,
                    maxRadius: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patras Tennis',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      'D.Gounari 25',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 40,
                  child: Icon(Icons.star, size: 20),
                ),
              ),
            ],
          ),
          Divider(
            indent: 87,
            height: 1,
            color: Color.fromARGB(79, 183, 179, 179),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
