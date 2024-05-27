import 'package:flutter/material.dart';
import 'package:mytennisclub/member_android_app/member_profile_screen/member_become_athlete/member_become_athlete_page.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen({super.key});

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MemberBecomeAthlete(),
                ),
              );
            });
          },
          child: const Text('Become Athlete')),
    );
  }
}
