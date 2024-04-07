import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBarCoach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text('Application'),
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
    );
  }
}
