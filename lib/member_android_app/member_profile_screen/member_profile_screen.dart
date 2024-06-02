import 'package:flutter/material.dart';
import 'package:mytennisclub/member_android_app/member_profile_screen/member_become_athlete/member_become_athlete_page.dart';
import 'package:mytennisclub/models/member.dart';

class MemberProfileScreen extends StatefulWidget {
  final int guestID;
  const MemberProfileScreen({required this.guestID, super.key});

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
          onPressed: () {
            setState(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        FutureBuilder<List<dynamic>>(
                      future: Member.getMemberInfo(widget.guestID),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No user retrieved'));
                        } else {
                          final memberInfo = snapshot.data!;

                          return MemberBecomeAthlete(memberInfo: memberInfo);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Become Athlete')),
    );
  }
}
