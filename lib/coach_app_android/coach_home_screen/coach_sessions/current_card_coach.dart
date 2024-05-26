import 'package:flutter/material.dart';

final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));


class CurrentCard extends StatefulWidget {

  const CurrentCard({super.key});

  @override
  State<CurrentCard> createState() => _CurrentCardState();
}

class _CurrentCardState extends State<CurrentCard> {
  // Store available height after layout
  double _containerHeigh = 0.0;
  double _sizeBox = 0.0;
  double _widthBox = 0.0;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( // Wrap content with LayoutBuilder
      builder: (context, constraints) {
        _containerHeigh = constraints.maxHeight; // Get available height
        _sizeBox = _containerHeigh/2 + _containerHeigh/6;
        _widthBox = constraints.maxWidth;
        return Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Group C',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _sizeBox,
                  width: _widthBox-10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // Align label to the left
                        children: [
                          const Text(
                            'Athletes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: _widthBox/2-30,
                            height:_sizeBox - _sizeBox/6,
                            child: const ListOfAthetesBox(),
                          )
                          // ListOfAthetesBox()
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          const Text(
                            'Attendace: 4/4',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: _widthBox/2-30,
                            height: 20,
                          ),
                          const Column(
                            children: [
                              Text(
                                'Time Remaining:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                '45 min',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            onPressed: (){},
                            style: buttonStyle,
                            child: const Text('Attendance Book'),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          onPressed: (){},
                          style: buttonStyle,
                          child: const Text('Trainning Program'),
                        ),
                      )
                    ],
                  ),
                )


              ],
            ),
          ),
        );
      },
    );
  }
}


class ListOfAthetesBox extends StatelessWidget {
  const ListOfAthetesBox({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> names = ["Alice", "Bob", "Charlie", "Alice", "Bob", "Charlie", "Alice", "Bob", "Charlie", "Alice", "Bob", "Charlie"];

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              names.length,
                  (index) => ListOfAthetes(index: index + 1, name: names[index]),
            ),
          ),
        ),
      );
    });
  }
}

class ListOfAthetes extends StatelessWidget {
  const ListOfAthetes({super.key, required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$index. $name',
      style: const TextStyle(
        fontSize: 16
      ),
    );
  }
}
