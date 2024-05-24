import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'select_athletes.dart';

class Details_Section extends StatefulWidget {
  final Function checkNumber;
  const Details_Section({required this.checkNumber, super.key});

  @override
  State<Details_Section> createState() => DetailsSection();
}

class DetailsSection extends State<Details_Section> {
  late TextEditingController _controller;
  bool numberCheck = true;
  int memberNumber = 3;

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
          flex: 2,
          child: SizedBox(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    widget.checkNumber(false, 0);
                  }
                  if (int.parse(value) > memberNumber) {
                    _errorText = 'Must be less than ${memberNumber.toString()}';
                    widget.checkNumber(false, 0);
                  } else {
                    _errorText = '';
                    widget.checkNumber(true, int.parse(value));
                  }
                  widget.checkNumber(numberCheck);
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
        Expanded(
          flex: 2,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Color.fromRGBO(0, 83, 135, 1),
                    size: 22,
                  ),
                ),
                TextSpan(
                  text: 'Select Athletes',
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 83, 135, 1), fontSize: 14),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Select_Athletes(),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
