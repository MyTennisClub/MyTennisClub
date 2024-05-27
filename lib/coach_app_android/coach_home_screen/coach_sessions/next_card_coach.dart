import 'package:flutter/material.dart';

final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

class NextCard extends StatefulWidget {

  const NextCard({super.key});

  @override
  State<NextCard> createState() => _NextCardState();
}

class _NextCardState extends State<NextCard> {
  // Store available height after layout
  double _containerHeigh = 0.0;

  double _sizeBox = 0.0;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( // Wrap content with LayoutBuilder
      builder: (context, constraints) {
        _containerHeigh = constraints.maxHeight; // Get available height
        _sizeBox = _containerHeigh/2 + _containerHeigh/6;
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
                      'Best Team',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _sizeBox,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
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
                            height:_sizeBox - _sizeBox/6,
                            child: const ListOfAthetesBox(),
                          )
                          // ListOfAthetesBox()
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.black26,
                      ),
                      const Column(

                        children: [
                          Text(
                            'Attendace: 5/5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                'Time Remaining:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                '5 min',
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
    final List<String> names = ["Voulgaris Nikolaos","Bakalis Athanasios","Baknis Georgios","Skandalos Athanasios Spiridon","Stamelos Charilaos Panagiotis"];

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            names.length,
                (index) => ListOfAthetes(index: index + 1, name: names[index]),
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
