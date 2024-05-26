import 'person.dart';

class Guest extends Person {
  String searchHistory;
  String recentViews;

  Guest({
    required int id,
    required String name,
    required String email,
    required String phone,
    required this.searchHistory,
    required this.recentViews,
  }) : super(id: id, name: name, email: email, phone: phone);
}
