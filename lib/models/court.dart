import 'package:mytennisclub/models/calendar.dart';

enum CourtType {
  hard,
  clay,
  grass,
}

class Court {
  final int id;
  final String name;
  final CourtType type;
  final bool covered;
  final int athlete_capacity;
  final Calendar? calendar;
  final double price;

  Court({
    required this.id,
    required this.name,
    required this.type,
    required this.covered,
    required this.athlete_capacity,
    required this.price,
    required this.calendar,
  });

  Calendar? getCalendar() {
    return calendar;
  }

  int get courtId {
    return id;
  }

  int get numAthletes {
    return athlete_capacity;
  }
}
