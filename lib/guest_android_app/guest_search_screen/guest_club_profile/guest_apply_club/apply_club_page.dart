import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'upload_files.dart';
import 'personal_info.dart';
import 'success_page.dart';
import 'package:mytennisclub/models/guest.dart';

enum Person { you, kid }

enum Type { member, athlete }

class ApplyClub_Main extends StatefulWidget {
  final List guestInfo;
  final int courtID;
  final int guestID;
  const ApplyClub_Main(
      {required this.courtID,
      required this.guestInfo,
      required this.guestID,
      super.key});

  @override
  State<ApplyClub_Main> createState() => ApplyClub();
}

@override
class ApplyClub extends State<ApplyClub_Main> {
  @override
  void initState() {
    super.initState();
  }

  Person personSelected = Person.you;
  Type typeSelected = Type.member;

  bool isChecked = false;
  bool allFields = true;
  bool uploadsCheck = false;
  bool submitEnabled = false;
  List<bool> uploads = [false, false, false];

  late String name = widget.guestInfo[0];
  late String phone = widget.guestInfo[3];
  late String address = widget.guestInfo[1];
  late String email = widget.guestInfo[2];
  late DateTime birthDate = widget.guestInfo[4];

  String kidName = '';
  String kidPhone = '';
  String kidAddress = '';
  String kidEmail = '';
  DateTime kidDate = DateTime.now();

  Uint8List? solemnDec;
  Uint8List? doctorsNote;
  Uint8List? identification;

  getNewValues(newName, newPhone, newAddress, newEmail, newDate) {
    setState(() {
      kidName = newName;
      kidPhone = newPhone;
      kidAddress = newAddress;
      kidEmail = newEmail;
      kidDate = newDate;
    });
  }

  getID(id) {
    setState(() {
      identification = id.bytes;
    });
  }

  getSolemn(solemn) {
    setState(() {
      solemnDec = solemn.bytes;
    });
  }

  getDoctors(doctors) {
    setState(() {
      doctorsNote = doctors.bytes;
    });
  }

  checkAllFields(check) {
    setState(() {
      allFields = check;
      checkSubmit(isChecked, allFields, uploadsCheck);
    });
  }

  checkEachUpload(check, check1, check2) {
    setState(() {
      uploads[0] = check;
      uploads[1] = check1;
      uploads[2] = check2;
      checkUploads();
    });
  }

  checkUploads() {
    setState(() {
      // User Selects 'You'
      if (personSelected.name == 'you' && uploads[0]) {
        if (typeSelected.name == 'athlete' && uploads[1]) {
          uploadsCheck = true;
        } else if (typeSelected.name == 'member') {
          uploadsCheck = true;
        } else {
          uploadsCheck = false;
        }

        // User Selects 'Register your Kid'
      } else if (personSelected.name == 'kid' && uploads[0] && uploads[2]) {
        if (typeSelected.name == 'athlete' && uploads[1]) {
          uploadsCheck = true;
        } else if (typeSelected.name == 'member') {
          uploadsCheck = true;
        } else {
          uploadsCheck = false;
        }
      } else {
        uploadsCheck = false;
      }
      checkSubmit(isChecked, allFields, uploadsCheck);
    });
  }

  checkSubmit(checkBox, checkFields, checkUpload) {
    setState(() {
      if (checkBox && checkFields && checkUpload) {
        submitEnabled = true;
      } else {
        submitEnabled = false;
      }
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(248, 249, 255, 1),
          title: const Row(
            children: [
              Text('Apply to Club',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Center(
                        child: SizedBox(
                          width: constraints.maxWidth * 0.80,
                          child: SegmentedButton(
                              segments: const <ButtonSegment<Person>>[
                                ButtonSegment<Person>(
                                  icon: Icon(null),
                                  value: Person.you,
                                  label: Text(
                                    'You',
                                  ),
                                ),
                                ButtonSegment<Person>(
                                  icon: Icon(null),
                                  value: Person.kid,
                                  label: Text(
                                    textAlign: TextAlign.center,
                                    'Register your Kid',
                                  ),
                                ),
                              ],
                              selected: <Person>{
                                personSelected
                              },
                              onSelectionChanged: (Set<Person> newSelection) {
                                setState(() {
                                  // By default there is only a single segment that can be
                                  // selected at one time, so its value is always the first
                                  // item in the selected set.
                                  personSelected = newSelection.first;
                                  if (personSelected.name == 'you') {
                                    checkAllFields(true);
                                  } else {
                                    checkAllFields(false);
                                  }
                                  checkUploads();
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Center(
                        child: SizedBox(
                          width: constraints.maxWidth * 0.80,
                          child: SegmentedButton(
                              segments: const <ButtonSegment<Type>>[
                                ButtonSegment<Type>(
                                  icon: Icon(null),
                                  value: Type.member,
                                  label: Text('Member'),
                                ),
                                ButtonSegment<Type>(
                                  icon: Icon(null),
                                  value: Type.athlete,
                                  label: Text('Athlete'),
                                ),
                              ],
                              selected: <Type>{
                                typeSelected
                              },
                              onSelectionChanged: (Set<Type> newSelection) {
                                setState(() {
                                  // By default there is only a single segment that can be
                                  // selected at one time, so its value is always the first
                                  // item in the selected set.
                                  typeSelected = newSelection.first;
                                  checkUploads();
                                });
                              }),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromRGBO(193, 199, 209, 1),
                    ),
                    Personal_Info(
                      getNewValues: getNewValues,
                      personSelected: personSelected.name,
                      checkAllFields: checkAllFields,
                      name: name,
                      phone: phone,
                      address: address,
                      email: email,
                      date: birthDate,
                    ),
                    const Divider(
                      color: Color.fromRGBO(193, 199, 209, 1),
                    ),
                    Upload_Files(
                      getID: getID,
                      getSolemn: getSolemn,
                      getDoctors: getDoctors,
                      personSelected: personSelected.name,
                      typeSelected: typeSelected.name,
                      checkEachUpload: checkEachUpload,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('I agree with the club TOS and Privacy Policy'),
                  Checkbox(
                    activeColor: const Color.fromRGBO(0, 83, 135, 1),
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        checkSubmit(isChecked, allFields, uploadsCheck);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const Spacer(),
                  (submitEnabled)
                      ? Expanded(
                          flex: 3,
                          child: FilledButton(
                            onPressed: () async {
                              if (personSelected.name == 'you' &&
                                  typeSelected.name == 'member') {
                                await Guest.guestApply(identification, null,
                                    'MEMBER', widget.courtID, widget.guestID);
                              } else if (personSelected.name == 'you' &&
                                  typeSelected.name == 'athlete') {
                                await Guest.guestApply(
                                    identification,
                                    doctorsNote,
                                    'ATHLETE',
                                    widget.courtID,
                                    widget.guestID);
                              } else if (personSelected.name == 'kid' &&
                                  typeSelected.name == 'member') {
                                await Guest.kidApply(
                                    identification,
                                    null,
                                    solemnDec,
                                    'MEMBER',
                                    widget.courtID,
                                    widget.guestID,
                                    kidName.split(' ')[0],
                                    kidName.split(' ')[1],
                                    kidDate,
                                    kidEmail,
                                    kidPhone,
                                    kidAddress);
                              } else if (personSelected.name == 'kid' &&
                                  typeSelected.name == 'athlete') {
                                await Guest.kidApply(
                                    identification,
                                    doctorsNote,
                                    solemnDec,
                                    'ATHLETE',
                                    widget.courtID,
                                    widget.guestID,
                                    kidName.split('')[0],
                                    kidName.split('')[1],
                                    kidDate,
                                    kidEmail,
                                    kidPhone,
                                    kidAddress);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Success_Page(),
                                ),
                              );
                            },
                            child: const Text('Submit'),
                          ),
                        )
                      : Expanded(
                          flex: 3,
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromRGBO(24, 28, 32, 0.12)),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: Color.fromRGBO(29, 27, 32, 0.6)),
                            ),
                          ),
                        ),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
