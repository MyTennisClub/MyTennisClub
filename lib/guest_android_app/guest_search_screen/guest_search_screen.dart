import 'package:flutter/material.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_club_profile.dart';

class GuestsSearchScreen extends StatefulWidget {
  final Function checkIndex;
  const GuestsSearchScreen({required this.checkIndex, super.key});

  @override
  State<GuestsSearchScreen> createState() => _GuestsSearchScreenState();
}

class _GuestsSearchScreenState extends State<GuestsSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const ClubInfo()))
                .then((value) {
              setState(() {
                print(value);
                widget.checkIndex(value);
              });
            });
          },
          child: const Text('Select Patras Tennis Club')),
    );
  }
}
