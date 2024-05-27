import 'package:flutter/material.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_club_profile.dart';

class GuestsSearchScreen extends StatefulWidget {
  const GuestsSearchScreen({super.key});

  @override
  State<GuestsSearchScreen> createState() => _GuestsSearchScreenState();
}

class _GuestsSearchScreenState extends State<GuestsSearchScreen> {
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
