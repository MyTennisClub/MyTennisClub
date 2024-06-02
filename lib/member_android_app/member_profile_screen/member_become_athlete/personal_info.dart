import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalInfo extends StatefulWidget {
  final List memberInfo;
  const PersonalInfo({required this.memberInfo, super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late String name = widget.memberInfo[0];
  late String phone = widget.memberInfo[3];
  late String address = widget.memberInfo[1];
  late String email = widget.memberInfo[2];
  late DateTime birthDate = widget.memberInfo[4];

  var phoneFormatter = MaskTextInputFormatter(
      mask: '###-####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                child: Icon(
                  Icons.person_outlined,
                  size: 24,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: true,
                    key: Key(name),
                    initialValue: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  )),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                  child: Icon(
                Icons.phone_outlined,
                size: 24,
              )),
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telephone',
                    ),
                    initialValue: phone,
                    key: Key(phone),
                  )),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                  child: Icon(
                Icons.home_outlined,
                size: 24,
              )),
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    initialValue: address,
                    key: Key(address),
                  )),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                  child: Icon(
                Icons.email_outlined,
                size: 24,
              )),
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                    initialValue: email,
                    key: Key(email),
                  )),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                  child: Icon(
                Icons.event_outlined,
                size: 24,
              )),
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Birth Date',
                    ),
                    keyboardType: TextInputType.datetime,
                    key: Key(DateFormat.yMMMMd().format(birthDate)),
                    initialValue: DateFormat.yMMMMd().format(birthDate),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
