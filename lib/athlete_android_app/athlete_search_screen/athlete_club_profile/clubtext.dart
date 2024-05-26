import 'package:flutter/material.dart';

class ClubText extends StatefulWidget {
  const ClubText({super.key});

  @override
  State<ClubText> createState() => _ClubTextState();
}

class _ClubTextState extends State<ClubText> {
  String address = 'D. Gounari 183, Patras';
  String tel = '+30 2610 996683';
  String email = 'name@domain.com';
  String amenities = 'Grass Court,Clay Court,Hard Court,Gym,Canteen';

  String printAmenities(equipment) {
    List<String> amenitiesList = equipment.split(',');
    String print = '';
    for (var i = 0; i < amenitiesList.length; i++) {
      print += amenitiesList[i];
      if (i != amenitiesList.length - 1) {
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
                          tel,
                        )),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
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
                      child: Text(printAmenities(amenities),
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
