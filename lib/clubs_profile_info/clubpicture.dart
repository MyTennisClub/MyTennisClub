import 'package:flutter/material.dart';

class ClubPicture extends StatelessWidget {
  const ClubPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
