import 'package:flutter/material.dart';

class MapClass extends StatelessWidget {
  const MapClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              // blurRadius: 0.5,
              // offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
