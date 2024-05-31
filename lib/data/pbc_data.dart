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

  for (var member in members) {
    Set<int> usedCourtIds = {}; // Track used courts for each member

    for (var i = 0; i < 2; i++) {
      // Each member should have 2 reservations
      int courtId;
      do {
        courtId = courts[random.nextInt(courts.length)].id;
      } while (usedCourtIds.contains(courtId)); // Ensure different courts

      usedCourtIds.add(courtId);

      // Find the court
      Court court = courts.firstWhere((c) => c.id == courtId);

      // Dates with one or two days difference from now
      DateTime date = DateTime.now().add(Duration(days: i + 1));

      // Possible start times
      List<DateTime> possibleStartTimes = [
        DateTime(date.year, date.month, date.day, 10, 0),
        DateTime(date.year, date.month, date.day, 11, 30),
        DateTime(date.year, date.month, date.day, 13, 0),
        DateTime(date.year, date.month, date.day, 14, 30),
        DateTime(date.year, date.month, date.day, 16, 0),
        DateTime(date.year, date.month, date.day, 17, 30),
        DateTime(date.year, date.month, date.day, 19, 0),
        DateTime(date.year, date.month, date.day, 20, 30),
      ];

      // Randomly select a start time
      DateTime startTime =
          possibleStartTimes[random.nextInt(possibleStartTimes.length)];

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

      DateTime endTime = startTime.add(duration);

      Event reservation = Event(
        type: Type.privateReservation,
        date: date,
        startTime: startTime,
        endTime: endTime,
        courtId: courtId,
        personId: member.id,
      );

      // Add the reservation to both the member's and the court's calendar
      member.calendar?.addEvent(reservation);
      court.calendar?.addEvent(reservation);

      reservations.add(reservation);
    }
  }
  for (var i = 0; i < reservations.length; i++) {
    print(
        '${reservations[i].personId} - ${reservations[i].courtId} - ${reservations[i].date} - ${reservations[i].startTime} - ${reservations[i].endTime} ');
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
