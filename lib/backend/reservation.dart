class Reservation {
  int id;
  int userId;
  int courtId;
  DateTime startTime;
  DateTime endTime;
  String status;
  double totalPrice;
  bool paid;

  Reservation({
    required this.id,
    required this.userId,
    required this.courtId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.totalPrice,
    required this.paid,
  });
}
