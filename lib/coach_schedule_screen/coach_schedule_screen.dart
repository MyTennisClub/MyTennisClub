import 'package:flutter/material.dart';
import 'package:mytennisclub/coach_book_session/book_session_page.dart';

class CoachScheduleScreen extends StatefulWidget {
  const CoachScheduleScreen({super.key});

  @override
  State<CoachScheduleScreen> createState() => _CoachScheduleScreenState();
}

class _CoachScheduleScreenState extends State<CoachScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BookSession_Main()));
          },
          child: const Text('Book Private Session')),
    );
  }
}
