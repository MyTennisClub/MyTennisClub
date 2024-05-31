import 'package:mytennisclub/models/calendar.dart';
import 'package:mytennisclub/models/event.dart';
import 'package:mytennisclub/models/member.dart';
import 'package:mytennisclub/models/court.dart';
import 'dart:math';

List<Member> createMembers() {
  return List.generate(10, (index) {
    return Member(
      calendar: Calendar(),
      searchHistory: [],
      bookHistory: [],
      reservations: [],
      reviews: [],
      id: index + 1,
      fullname: 'Member ${index + 1}',
      tel: '12345678${index + 1}',
      address: 'Address ${index + 1}',
      birthdate: DateTime(1990, 1, 1).add(Duration(days: index * 365)),
      email: 'member${index + 1}@example.com',
      startDate: DateTime(2020, 1, 1),
    );
  });
}

List<Court> createCourts() {
  return List.generate(5, (index) {
    final types = [CourtType.hard, CourtType.clay, CourtType.grass];
    final type = types[index % types.length];
    return Court(
      id: index + 1,
      name: 'Court ${String.fromCharCode(65 + index)}',
      type: type,
      covered: index % 2 == 0,
      athlete_capacity: 2 + (index % 3),
      price: 10.0 + (index * 5.0),
      calendar: Calendar(),
    );
  });
}

List<Event> createReservations(List<Member> members, List<Court> courts) {
  Random random = Random();
  List<Event> reservations = [];
  for (var index = 0; index < 20; index++) {
    int memberId = (index % members.length) + 1;
    int courtId = (index % courts.length) + 1;

    // Find the member and court
    Member member = members.firstWhere((m) => m.id == memberId);
    Court court = courts.firstWhere((c) => c.id == courtId);

    // Dates with one index days difference from now
    DateTime date = DateTime.now().add(Duration(days: index));

    // Generate random duration in a specified range of hours an minutes
    int durationIndex = random.nextInt(4); // Random number between 0 and 3
    Duration duration;
    switch (durationIndex) {
      case 0:
        duration = const Duration(hours: 1);
        break;
      case 1:
        duration = const Duration(hours: 1, minutes: 30);
        break;
      case 2:
        duration = const Duration(hours: 2);
        break;
      case 3:
        duration = const Duration(hours: 2, minutes: 30);
        break;
      default:
        duration = const Duration(hours: 1); // Default duration
    }

    DateTime endTime = date.add(duration);

    // Extract hour and minute from startTime
    int startHour = date.hour;
    int startMinute = date.minute;
    // Set endTime to one hour after startTime
    int endHour = endTime.hour;
    int endMinute = endTime.minute;

    // Create new DateTime objects with only hour and minute components
    DateTime startTimeHourMinute = DateTime(startHour, startMinute);
    DateTime endTimeHourMinute = DateTime(endHour, endMinute);

    Event reservation = Event(
      type: Type.privateReservation,
      date: date,
      startTime: startTimeHourMinute,
      endTime: endTimeHourMinute,
      courtId: courtId,
      personId: memberId,
    );

    // Add the reservation to both the member's and the court's calendar
    member.calendar?.addEvent(reservation);
    court.calendar?.addEvent(reservation);

    reservations.add(reservation);
  }
  return reservations;
}

// Helper function to generate hours in the specified range
List<DateTime> _generateHoursInRange(DateTime date) {
  List<DateTime> hours = [];
  for (int hour = 17; hour <= 23; hour++) {
    hours.add(DateTime(date.year, date.month, date.day, hour));
  }
  return hours;
}

List<DateTime> getAvailableHoursForCourt(
  Court court,
  DateTime date,
  String duration,
) {
  List<DateTime> availableHours = [];
  List<DateTime> hoursInRange = _generateHoursInRange(date);

  duration = duration.replaceAll(' h', '');
  List<String> parts = duration.split(':');
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);

  Duration durationObj = Duration(hours: hours, minutes: minutes);

  for (DateTime hour in hoursInRange) {
    DateTime endHour = hour.add(durationObj);
    bool isAvailable = true;

    for (Event event in court.calendar?.events ?? []) {
      if (event.startTime.isBefore(endHour) && event.endTime.isAfter(hour)) {
        isAvailable = false;
        break;
      }
    }

    if (isAvailable) {
      availableHours.add(hour);
    }
  }

  return availableHours;
}
