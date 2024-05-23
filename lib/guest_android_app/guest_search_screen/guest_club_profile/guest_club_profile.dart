import 'package:flutter/material.dart';
import 'bottomnavigationbar_guest.dart';
import 'clubtext.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_apply_club/apply_club_page.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_book_court/book_court_page.dart';

class ClubInfo extends StatefulWidget {
  const ClubInfo({super.key});

  @override
  State<ClubInfo> createState() => _ClubInfoState();
}

class _ClubInfoState extends State<ClubInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(236, 238, 243, 1),
            title: const Text('Patras Tennis Club',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Info',
                ),
                Tab(
                  text: 'Announcements',
                ),
                Tab(
                  text: 'Reviews',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const ClubText(),
                            Center(
                              child: SizedBox(
                                width: constraints.maxWidth * 0.66,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(0, 83, 135, 1)
                                      // This is what you need!
                                      ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ApplyClub_Main(),
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
                                      backgroundColor:
                                          const Color.fromRGBO(0, 83, 135, 1)
                                      // This is what you need!
                                      ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const BookCourt_Main(),
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
              ),
              const Center(
                child: Text("Announcements"),
              ),
              const Center(
                child: Text("Reviews"),
              ),
            ],
          ),
          bottomNavigationBar: const GuestBottomNavigationBar(),
        ),
      ),
    );
  }
}
