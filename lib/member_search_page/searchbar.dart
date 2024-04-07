import 'package:flutter/material.dart';
import 'searchbar_member.dart';

class SearchBar1 extends StatelessWidget {
  const SearchBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
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
    );
  }
}
