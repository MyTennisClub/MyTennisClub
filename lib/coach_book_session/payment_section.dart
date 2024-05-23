import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Payment_Section extends StatefulWidget {
  final Function checkPayment;
  const Payment_Section({required this.checkPayment, super.key});

  @override
  State<Payment_Section> createState() => PaymentSection();
}

class PaymentSection extends State<Payment_Section> {
  late TextEditingController _controller;
  bool payment = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '5');
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
                setState(() {
                  if (value.isEmpty) {
                    widget.checkPayment(false, 0);
                  } else {
                    widget.checkPayment(true, int.parse(value));
                  }
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Enter',
                  border: OutlineInputBorder(),
                  labelText: 'Payment'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
