import 'package:flutter/material.dart';
import 'package:mytennisclub/member_android_app/member_profile_screen/member_become_athlete/member_become_athlete_page.dart';
import 'package:mytennisclub/models/member.dart';

class MemberProfileScreen extends StatefulWidget {
  final int memberID;
  const MemberProfileScreen({required this.memberID, super.key});

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
                      future: Member.getMemberInfo(widget.memberID),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No member retrieved'));
                        } else {
                          final memberInfo = snapshot.data!;

                          return MemberBecomeAthlete(
                              memberID: widget.memberID,
                              memberInfo: memberInfo);
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
