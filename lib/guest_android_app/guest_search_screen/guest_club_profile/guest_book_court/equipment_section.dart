import 'package:flutter/material.dart';

class Equipment_Section extends StatefulWidget {
  final Function checkEquipment;
  const Equipment_Section({required this.checkEquipment, super.key});

  @override
  State<Equipment_Section> createState() => EquipmentSection();
}

class EquipmentSection extends State<Equipment_Section> {
  bool isChecked = false;
  String items = 'Rackers×2, Balls×3, Wristbands×3';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.sports_tennis_outlined),
        ),
        const Expanded(
          flex: 2,
          child: Text(
            'Rent Equipment',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 1,
          child: Checkbox(
            activeColor: const Color.fromRGBO(0, 83, 135, 1),
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                widget.checkEquipment(isChecked);
              });
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: Tooltip(
            decoration:
                const BoxDecoration(color: Color.fromARGB(141, 0, 0, 0)),
            preferBelow: true,
            richMessage: TextSpan(
              text: "Additional Costs 5€",
              children: <InlineSpan>[
                TextSpan(
                  text: '\nItems: $items',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            child: const Icon(
              Icons.help,
              color: Color.fromRGBO(0, 83, 135, 0.611),
            ),
          ),
        ),
        const Spacer(flex: 1)
      ],
    );
  }
}
