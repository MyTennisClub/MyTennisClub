import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date_Section extends StatefulWidget {
  final Function getDate;
  const Date_Section({required this.getDate, super.key});

  @override
  State<Date_Section> createState() => DateSection();
}

class DateSection extends State<Date_Section> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.calendar_month_outlined),
        Expanded(
          flex: 1,
          child: Text(
            textAlign: TextAlign.center,
            DateFormat.yMd().format(selectedDate),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 2,
          child: OutlinedButton(
            onPressed: () => (_showDatePicker()),
            child: const Text('Edit',
                style: TextStyle(color: Color.fromRGBO(0, 83, 135, 1))),
          ),
        )
      ],
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.getDate(selectedDate);
      });
    }
  }
}
