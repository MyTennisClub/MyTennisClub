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
  bool number = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '1');
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
                    widget.checkNumber(false, 0);
                  }
                  if (int.parse(value) > 4) {
                    _errorText = 'Must be less than 4';
                    widget.checkNumber(false, 0);
                  } else {
                    _errorText = '';
                    widget.checkNumber(true, int.parse(value));
                  }
                  widget.checkNumber(number);
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