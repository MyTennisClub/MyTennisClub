import 'bottomnavigationbar_member.dart';
import 'map_member.dart';
import 'itemmember.dart';
import 'searchbar_member.dart';
import 'package:flutter/material.dart';

class MemberSearchPage extends StatelessWidget {
  const MemberSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MemberAppBar(),
    );
  }
}

class MemberAppBar extends StatelessWidget {
  const MemberAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            //leadingWidth: 35.0,
            title: const Text(
              'MyTennisClub',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.notifications,
                    size: 33,
                  ),
                  splashColor: Colors.transparent,
                  tooltip: 'Show Notifications',
                  highlightColor: Colors.transparent,
                ),
              ),
            ],
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0),
                                child: SearchBarClass(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Icon(
                                  Icons.menu,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                const Expanded(
                  flex: 10,
                  child: MapClass(),
                ),
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tennis Clubs Found',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: const Color.fromARGB(79, 46, 45, 45),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 224, 224, 224),
                            // blurRadius: 0.5,
                            // offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const SpacedItemsList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CoachBottomNavigationBar(),
        ),
      ),
    );
  }
}
