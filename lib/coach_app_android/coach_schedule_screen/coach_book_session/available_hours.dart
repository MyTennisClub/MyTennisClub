import 'package:flutter/material.dart';

class Available_Hours extends StatefulWidget {
  final Function checkHour;
  final int id;
  Available_Hours({required this.checkHour, required this.id});
  @override
  State<Available_Hours> createState() => AvailableHours();
}

class AvailableHours extends State<Available_Hours> {
  var hourList = ['9:00', '10:30', '12:00', '13:00', '14:00', '16:00'];
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(physics: const NeverScrollableScrollPhysics(), children: [
        Wrap(
          direction: Axis.horizontal,
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(
            hourList.length,
            (int i) {
              return ChoiceChip(
                selectedColor: const Color.fromRGBO(210, 230, 255, 1),
                label: Text(hourList[i]),
                selected: selectedHour == i,
                onSelected: (bool selected) {
                  setState(() {
                    selectedHour = selected ? i : null;
                    if (selectedHour == null) {
                      widget.checkHour(selected, widget.id, null);
                    }
                    if (selectedHour != null) {
                      widget.checkHour(selected, widget.id, hourList[i]);
                    }
                  });
                },
              );
            },
          ).toList(),
        ),
      ]),
    );
  }
}
