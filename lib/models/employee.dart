import 'dart:ffi';

import 'package:mytennisclub/models/person.dart';

class Employee extends Person {
  const Employee({
    required this.Identification,
    required this.cvFile,
    required this.leaveDays,
    required this.salary,
    required super.id,
    required super.fullname,
    required super.tel,
    required super.address,
    required super.birthdate,
    required super.email,
    required super.startDate,
  });

  final String Identification;
  final String cvFile;
  final String leaveDays;
  final Double salary;
}
