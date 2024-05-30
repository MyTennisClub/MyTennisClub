import 'package:flutter/material.dart';

class Duration_Section extends StatefulWidget {
  final Function checkDuration;
  const Duration_Section({required this.checkDuration, super.key});

  @override
  State<Duration_Section> createState() => DurationSection();
}

class DurationSection extends State<Duration_Section> {
  int? _value = 0;
  bool duration = true;
  var durationList = ['1:00 h', '1:30 h', '2:00 h', '2:30 h'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Icon(Icons.timer_outlined),
        ),
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List<Widget>.generate(
              durationList.length,
              (int i) {
                return ChoiceChip(
                  selectedColor: const Color.fromRGBO(210, 230, 255, 1),
                  label: Text(durationList[i]),
                  selected: _value == i,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected && _value != i) {
                        _value = i;
                        widget.checkDuration(true, durationList[i]);
                      }
                    });
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
