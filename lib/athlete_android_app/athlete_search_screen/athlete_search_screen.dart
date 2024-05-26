import 'package:flutter/material.dart';
import 'athlete_club_profile/athlete_club_profile.dart';

class AthleteSearchScreen extends StatefulWidget {
  const AthleteSearchScreen({super.key});

  @override
  State<AthleteSearchScreen> createState() => _GuestsSearchScreenState();
}

class _GuestsSearchScreenState extends State<AthleteSearchScreen> {
  bool profileSelected = false;
  @override
  Widget build(BuildContext context) {
    return (!profileSelected)
        ? Center(
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    profileSelected = true;
                  });
                },
                child: const Text('Select Patras Tennis Club')),
          )
        : const ClubProfile();
  }
}
