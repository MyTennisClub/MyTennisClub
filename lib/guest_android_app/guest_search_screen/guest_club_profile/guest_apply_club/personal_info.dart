import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class Personal_Info extends StatefulWidget {
  final String personSelected;
  final Function checkAllFields;
  const Personal_Info(
      {required this.personSelected, required this.checkAllFields, super.key});

  @override
  State<Personal_Info> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<Personal_Info> {
  List<bool> fields = [false, false, false, false, false];
  bool checker = false;

  String name = 'Nikolaos Voulgaris';
  String phone = '6971662770';
  String address = 'Agiou Andreou 16';
  String email = 'nickvoul3@gmail.com';
  String date = 'March 9, 2024';
  String _errorText = '';
  TextEditingController dateController = TextEditingController();

  bool validate(String email) {
    bool isvalid = EmailValidator.validate(email);
    return isvalid;
  }

  var phoneFormatter = MaskTextInputFormatter(
      mask: '###-####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  checkAllFields() {
    checker = fields.every((i) => i == true);
    widget.checkAllFields(checker);
  }

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
                child: (widget.personSelected == 'you')
                    ? TextFormField(
                        readOnly: true,
                        key: Key(name),
                        initialValue: name,
                        decoration: const InputDecoration(
                          hintText: 'Enter Name and Surname',
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                      )
                    : TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Name and Surname',
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              fields[0] = false;
                            } else {
                              fields[0] = true;
                            }
                            checkAllFields();
                          });
                        },
                      ),
              ),
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
                child: (widget.personSelected == 'you')
                    ? TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter Phone Number',
                          border: OutlineInputBorder(),
                          labelText: 'Telephone',
                        ),
                        initialValue: phone,
                        key: Key(phone),
                      )
                    : TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Phone Number',
                          border: OutlineInputBorder(),
                          labelText: 'Telephone',
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [phoneFormatter],
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              fields[1] = false;
                            } else {
                              fields[1] = true;
                            }
                            checkAllFields();
                          });
                        },
                      ),
              ),
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
                child: (widget.personSelected == 'you')
                    ? TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter Home Address',
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                        ),
                        initialValue: address,
                        key: Key(address),
                      )
                    : TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Home Address',
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                        ),
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              fields[2] = false;
                            } else {
                              fields[2] = true;
                            }
                            checkAllFields();
                          });
                        },
                      ),
              ),
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
                child: (widget.personSelected == 'you')
                    ? TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: 'someone@example.com',
                            border: const OutlineInputBorder(),
                            labelText: 'Email Address',
                            errorText: _errorText.isEmpty ? null : _errorText),
                        initialValue: email,
                        key: Key(email),
                      )
                    : TextFormField(
                        decoration: InputDecoration(
                            hintText: 'someone@example.com',
                            border: const OutlineInputBorder(),
                            labelText: 'Email Address',
                            errorText: _errorText.isEmpty ? null : _errorText),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              fields[3] = false;
                            } else {
                              if (validate(value)) {
                                fields[3] = true;
                                _errorText = '';
                              } else {
                                _errorText = 'Invalid Format';
                              }
                            }
                            checkAllFields();
                          });
                        },
                      ),
              ),
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
                child: (widget.personSelected == 'you')
                    ? TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Birth Date',
                        ),
                        keyboardType: TextInputType.datetime,
                        key: Key(date),
                        initialValue: date,
                      )
                    : TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Birth Date',
                        ),
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025));
                          if (pickeddate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat.yMMMMd().format(pickeddate);

                              fields[4] = true;
                              checkAllFields();
                            });
                          }
                        },
                      ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
