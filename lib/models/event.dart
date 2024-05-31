enum Type {
  privateReservation,
  publicReservation,
}

class Event {
  final Type type;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int courtId;
  final int personId;

  Event({
    required this.type,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.courtId,
    required this.personId,
  });
}
