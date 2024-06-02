import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class Personal_Info extends StatefulWidget {
  final Function getNewValues;
  final String name;
  final String phone;
  final String address;
  final String email;
  final DateTime date;
  final String personSelected;
  final Function checkAllFields;
  const Personal_Info(
      {required this.getNewValues,
      required this.personSelected,
      required this.checkAllFields,
      required this.name,
      required this.phone,
      required this.address,
      required this.email,
      required this.date,
      super.key});

  @override
  State<Personal_Info> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<Personal_Info> {
  List<bool> fields = [false, false, false, false, false];
  bool checker = false;

  String name = '';
  String phone = '';
  String address = '';
  String email = '';
  DateTime? date;
  String nameErrorText = '';
  String emailErrorText = '';
  TextEditingController dateController = TextEditingController();

  bool fullNameValidate(String fullName) {
    final RegExp regExp = RegExp(r"^[a-zA-Z]+([ '-][a-zA-Z]+)+$");
    bool isValid = regExp.hasMatch(fullName);
    print(isValid);
    return isValid;
  }

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
    setState(() {
      if (checker) {
        widget.getNewValues(name, phone, address, email, date);
      }
    });
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
                        initialValue: widget.name,
                        decoration: const InputDecoration(
                          hintText: 'Enter Name and Surname',
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                      )
                    : TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Name and Surname',
                          border: const OutlineInputBorder(),
                          labelText: 'Full Name',
                          errorText:
                              nameErrorText.isEmpty ? null : nameErrorText,
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              fields[0] = false;
                            } else {
                              if (fullNameValidate(value)) {
                                fields[0] = true;
                                nameErrorText = '';
                                name = value;
                              } else {
                                nameErrorText = 'Invalid Format';
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
                        initialValue: widget.phone,
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
                              phone = value;
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
                        initialValue: widget.address,
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
                              address = value;
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
                            errorText:
                                emailErrorText.isEmpty ? null : emailErrorText),
                        initialValue: widget.email,
                        key: Key(email),
                      )
                    : TextFormField(
                        decoration: InputDecoration(
                            hintText: 'someone@example.com',
                            border: const OutlineInputBorder(),
                            labelText: 'Email Address',
                            errorText:
                                emailErrorText.isEmpty ? null : emailErrorText),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              fields[3] = false;
                            } else {
                              if (validate(value)) {
                                print(value);
                                fields[3] = true;
                                email = value;
                                emailErrorText = '';
                              } else {
                                emailErrorText = 'Invalid Format';
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
                        key: Key(DateFormat.yMMMMd().format(widget.date)),
                        initialValue: DateFormat.yMMMMd().format(widget.date),
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
                              initialDate: DateTime(2024),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (pickeddate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat.yMMMMd().format(pickeddate);
                              date = pickeddate.toUtc();

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
