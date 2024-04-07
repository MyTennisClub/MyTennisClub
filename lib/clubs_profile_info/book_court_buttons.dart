import 'package:flutter/material.dart';

class BookCourtButtons extends StatelessWidget {
  const BookCourtButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text("Apply to Club",
              style: TextStyle(fontSize: 14, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(330, 30),
            backgroundColor: Color.fromRGBO(60, 111, 159, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          onPressed: () => null,
        ),
        ElevatedButton(
          child: Text("Book a Court",
              style: TextStyle(fontSize: 14, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(330, 30),
            backgroundColor: Color.fromRGBO(60, 111, 159, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () => null,
        )
      ],
    );
  }
}
