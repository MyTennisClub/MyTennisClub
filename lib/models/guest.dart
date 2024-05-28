import 'package:mytennisclub/models/person.dart';

class Guest extends Person {
  const Guest({
    required this.searchHistory,
    required this.bookHistory,
    required this.reservations,
    required this.reviews,
    required super.id,
    required super.fullname,
    required super.tel,
    required super.address,
    required super.birthdate,
    required super.email,
    required super.startDate,
  });

  final List<String> searchHistory;
  final List<String> bookHistory;
  final List<String> reservations;
  final List<String> reviews;
}
