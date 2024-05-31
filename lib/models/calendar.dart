import 'package:mytennisclub/models/event.dart';

class Calendar {
  final List<Event> events;

  Calendar({List<Event>? events}) : events = events ?? [];

  // Add an event to the calendar
  void addEvent(Event event) {
    events.add(event);
  }

  // Remove an event from the calendar
  void removeEvent(Event event) {
    events.remove(event);
  }

  // Get events for a specific day
  List<Event> getEventsForDay(DateTime date) {
    return events
        .where((event) =>
            event.startTime.year == date.year &&
            event.startTime.month == date.month &&
            event.startTime.day == date.day)
        .toList();
  }

  // Get events for a specific month
  List<Event> getEventsForMonth(int year, int month) {
    return events
        .where((event) =>
            event.startTime.year == year && event.startTime.month == month)
        .toList();
  }

  // Get events for a specific week
  List<Event> getEventsForWeek(DateTime startOfWeek) {
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return events
        .where((event) =>
            event.startTime.isAfter(startOfWeek) &&
            event.startTime.isBefore(endOfWeek))
        .toList();
  }

  // Retrieve all events
  List<Event> getAllEvents() {
    return List.from(events);
  }
}
