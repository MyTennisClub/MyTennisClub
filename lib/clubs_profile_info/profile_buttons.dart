import 'package:flutter/material.dart';

class ProfileButtons extends StatefulWidget {
  const ProfileButtons({super.key});

  @override
  State<ProfileButtons> createState() => _ProfileButtons();
}

class _ProfileButtons extends State<ProfileButtons> {
  bool InfoPressed = true;
  bool AnnouncePressed = false;
  bool ReviewPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: InfoPressed
                        ? Color.fromRGBO(60, 111, 159, 1)
                        : Colors.white),
                onPressed: () {
                  setState(() {
                    InfoPressed = true;
                    AnnouncePressed = false;
                    ReviewPressed = false;
                  });
                },
                child: Text(
                  'Info',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: InfoPressed ? Colors.white : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AnnouncePressed
                        ? Color.fromRGBO(60, 111, 159, 1)
                        : Colors.white),
                onPressed: () {
                  setState(() {
                    AnnouncePressed = true;
                    InfoPressed = false;
                    ReviewPressed = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Announcements',
                    style: TextStyle(
                      color: AnnouncePressed ? Colors.white : Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ReviewPressed
                        ? Color.fromRGBO(60, 111, 159, 1)
                        : Colors.white),
                onPressed: () {
                  setState(() {
                    ReviewPressed = true;
                    AnnouncePressed = false;
                    InfoPressed = false;
                  });
                },
                child: Text(
                  'Review',
                  style: TextStyle(
                    color: ReviewPressed ? Colors.white : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
