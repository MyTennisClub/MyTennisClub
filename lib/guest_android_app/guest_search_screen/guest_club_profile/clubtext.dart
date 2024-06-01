import 'package:flutter/material.dart';

class ClubText extends StatefulWidget {
  final List info;
  const ClubText({required this.info, super.key});

  @override
  State<ClubText> createState() => _ClubTextState();
}

class _ClubTextState extends State<ClubText> {
  late String address = widget.info[1];
  late List<String> tel = widget.info[4];
  late String email = widget.info[2];
  late List<String> amenities = widget.info[3];

  String printList(list) {
    String print = '';
    for (var i = 0; i < list.length; i++) {
      print += list[i];
      if (i != list.length - 1) {
        print += '\n';
      }
    }
    return print;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text('Address',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Expanded(flex: 3, child: Text(address)),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text('Tel',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Expanded(
                        flex: 3,
                        child: Text(
                          printList(tel),
                        )),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text('Email',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Expanded(flex: 3, child: Text(email)),
                    const Spacer(),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text('Amenities',
                        style:
                            TextStyle(fontWeight: FontWeight.w500, height: 2)),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(printList(amenities),
                          style: const TextStyle(height: 2))),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
