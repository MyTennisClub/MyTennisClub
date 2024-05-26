import 'package:flutter/material.dart';

class Payment_Section extends StatefulWidget {
  final Function checkPayment;
  const Payment_Section({required this.checkPayment, super.key});

  @override
  State<Payment_Section> createState() => PaymentSection();
}

class PaymentSection extends State<Payment_Section> {
  bool payment = true;

  late TextEditingController _controller;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '5.0');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.attach_money_outlined),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            child: TextField(
              onChanged: (value) {
                print(value);
                setState(() {
                  if (value.isEmpty) {
                    widget.checkPayment(false, 0.0);
                  } else {
                    try {
                      _errorText = '';
                      widget.checkPayment(true, double.parse(value));
                    } on FormatException catch (_) {
                      _errorText = 'Incorrect Format';
                      widget.checkPayment(false, 0.0);
                    }
                  }
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter',
                  border: const OutlineInputBorder(),
                  labelText: 'Payment',
                  errorText: _errorText.isEmpty ? null : _errorText),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _controller,
            ),
          ),
        ),
        const Spacer(
          flex: 2,
        )
      ],
    );
  }
}
