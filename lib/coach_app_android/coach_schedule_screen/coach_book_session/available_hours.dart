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
      height: calculateHeight(), // Call a function to calculate the height
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 8.0,
        runSpacing:
            4.0, // Adjust this value to change the vertical spacing between rows
        children: List<Widget>.generate(
          widget.availableHours.length,
          (int i) {
            final dateTime = widget.availableHours[i];
            final formattedTime = DateFormat('H:mm').format(dateTime);
            return ChoiceChip(
              selectedColor: const Color.fromRGBO(210, 230, 255, 1),
              label: Text(formattedTime),
              selected: selectedHour == i && widget.isVisible,
              onSelected: (bool selected) {
                setState(() {
                  if (selected && selectedHour != i) {
                    selectedHour = i;
                    widget.checkHour(selected, widget.id, formattedTime);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }

  double calculateHeight() {
    final double rowHeight = 48.0; // Height of each row
    final int numChipsPerRow = 4; // Number of chips per row
    final int numRows = (widget.availableHours.length / numChipsPerRow).ceil();
    final double verticalSpacing = 4.0; // Vertical spacing between rows
    return rowHeight * numRows + (numRows - 1) * verticalSpacing;
  }
}
