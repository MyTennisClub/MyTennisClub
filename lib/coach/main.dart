import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_bar_coach.dart';
import 'home_page_coach.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Patras Tennis Club'),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.arrow_drop_down, size: 35.0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
          leadingWidth: 35.0,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.notifications,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        ),
        body: CoachHomePage(),
        bottomNavigationBar: CoachBottomNavigationBar()
      )),
    );
  }
}
