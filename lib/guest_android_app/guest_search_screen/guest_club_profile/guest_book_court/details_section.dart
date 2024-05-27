import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Details_Section extends StatefulWidget {
  final Function checkNumber;
  const Details_Section({required this.checkNumber, super.key});

  @override
  State<Details_Section> createState() => DetailsSection();
}

class DetailsSection extends State<Details_Section> {
  late TextEditingController _controller;
  bool numberCheck = true;
  int number = 1;
  int allowedMembers = 4;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '$number');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _errorText = ('');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.group_outlined),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    numberCheck = false;
                    number = 0;
                  } else if (int.parse(value) > allowedMembers) {
                    _errorText =
                        'Must be less than ${allowedMembers.toString()}';
                    numberCheck = false;
                    number = 0;
                  } else if (int.parse(value) == 0) {
                    _errorText = "Number can't be zero";
                    numberCheck = false;
                    number = 0;
                  } else {
                    _errorText = '';
                    numberCheck = true;
                    number = int.parse(value);
                  }
                  widget.checkNumber(numberCheck, number);
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter number',
                  border: const OutlineInputBorder(),
                  labelText: 'Number of Athletes',
                  errorText: _errorText.isEmpty ? null : _errorText),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: _controller,
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
