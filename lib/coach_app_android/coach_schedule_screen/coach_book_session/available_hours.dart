import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Available_Hours extends StatefulWidget {
  final Function checkHour;
  final int id; //court
  final bool isVisible;
  final List<DateTime> availableHours;
  const Available_Hours({
    super.key,
    required this.checkHour,
    required this.id,
    required this.isVisible,
    required this.availableHours,
  });
  @override
  State<Available_Hours> createState() => AvailableHours();
}

class AvailableHours extends State<Available_Hours> {
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(physics: const NeverScrollableScrollPhysics(), children: [
        Wrap(
          direction: Axis.horizontal,
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(
            widget.availableHours
                .map((dateTime) {
                  // Using DateFormat to format the time part of DateTime
                  return DateFormat('H:mm').format(dateTime);
                })
                .toList()
                .length,
            (int i) {
              return ChoiceChip(
                selectedColor: const Color.fromRGBO(210, 230, 255, 1),
                label: Text(widget.availableHours.map((dateTime) {
                  // Using DateFormat to format the time part of DateTime
                  return DateFormat('H:mm').format(dateTime);
                }).toList()[i]),
                selected: selectedHour == i && widget.isVisible,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected && selectedHour != i) {
                      selectedHour = i;
                      widget.checkHour(
                          selected,
                          widget.id,
                          widget.availableHours.map((dateTime) {
                            // Using DateFormat to format the time part of DateTime
                            return DateFormat('H:mm').format(dateTime);
                          }).toList()[i]);
                    }
                    //selectedHour = selected ? i : null;
                    // if (selectedHour == null) {
                    //   widget.checkHour(selected, widget.id, null);
                    // }
                    // if (selectedHour != null) {
                    //   widget.checkHour(selected, widget.id, hourList[i]);
                    // }
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
