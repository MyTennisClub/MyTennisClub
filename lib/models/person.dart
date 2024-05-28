class Person {
  const Person({
    required this.id,
    required this.fullname,
    required this.tel,
    required this.address,
    required this.birthdate,
    required this.email,
    required this.startDate,
  });

  final String id;
  final String fullname;
  final String tel;
  final String address;
  final DateTime birthdate;
  final String email;
  final DateTime startDate;
}
