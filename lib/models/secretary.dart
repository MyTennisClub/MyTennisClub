import 'package:mytennisclub/models/employee.dart';
import 'package:mytennisclub/models/person.dart';

class Secretary extends Employee {
  Secretary({
    required this.cameraPermissions,
    required super.id,
    required super.fullname,
    required super.tel,
    required super.address,
    required super.birthdate,
    required super.email,
    required super.startDate,
    required super.Identification,
    required super.cvFile,
    required super.leaveDays,
    required super.salary,
  });

  String cameraPermissions;
}
