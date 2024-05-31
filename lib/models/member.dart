import 'package:mytennisclub/models/calendar.dart';
import 'package:mytennisclub/models/guest.dart';

class Member extends Guest {
  final Calendar? calendar;

  Member({
    required this.calendar,
    required super.searchHistory,
    required super.bookHistory,
    required super.reservations,
    required super.reviews,
    required super.id,
    required super.fullname,
    required super.tel,
    required super.address,
    required super.birthdate,
    required super.email,
    required super.startDate,
  });

  Calendar? getCalendar() {
    return calendar;
  }
}
