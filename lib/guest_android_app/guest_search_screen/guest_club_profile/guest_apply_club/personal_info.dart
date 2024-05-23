import 'package:flutter/material.dart';

class Personal_Info extends StatefulWidget {
  final Function checkAllFields;
  const Personal_Info({required this.checkAllFields, super.key});

  @override
  State<Personal_Info> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<Personal_Info> {
  List<bool> fields = [false, false, false, false, false];
  bool checker = false;

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
                child: TextField(
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
                  // controller: _controller,
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
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Telephone Number',
                    border: OutlineInputBorder(),
                    labelText: 'Telephone',
                  ),
                  keyboardType: TextInputType.phone,
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
                  //controller: _controller,
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
                child: TextField(
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
                  //controller: _controller,
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
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Email Address',
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        fields[3] = false;
                      } else {
                        fields[3] = true;
                      }
                      checkAllFields();
                    });
                  },
                  //controller: _controller,
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
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Birth Date',
                    border: OutlineInputBorder(),
                    labelText: 'Birth Date',
                  ),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        fields[4] = false;
                      } else {
                        fields[4] = true;
                      }
                      checkAllFields();
                    });
                  },
                  //controller: _controller,
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
