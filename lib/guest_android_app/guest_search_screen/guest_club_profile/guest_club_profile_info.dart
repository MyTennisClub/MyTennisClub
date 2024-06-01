import 'package:flutter/material.dart';
import 'clubtext.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_apply_club/apply_club_page.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_book_court/book_court_page.dart';

class ClubInfo extends StatefulWidget {
  final List info;
  const ClubInfo({required this.info, super.key});

  @override
  State<ClubInfo> createState() => _ClubInfoState();
}

class _ClubInfoState extends State<ClubInfo> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8),
                    child: Container(
                      height: constraints.maxHeight / 4,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(236, 238, 243, 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClubText(info: widget.info),
                  Center(
                    child: SizedBox(
                      width: constraints.maxWidth * 0.66,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 83, 135, 1)
                            // This is what you need!
                            ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ApplyClub_Main(),
                              ),
                            );
                          });
                        },
                        child: const Text('Apply to Club'),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: constraints.maxWidth * 0.66,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 83, 135, 1)
                            // This is what you need!
                            ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BookCourt_Main(),
                              ),
                            );
                          });
                        },
                        child: const Text('Book a Court'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
