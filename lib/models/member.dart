import 'dart:typed_data';

import 'package:mytennisclub/Database/ConnectionDatabase.dart';
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

  static Future<void> memberApply(
      Uint8List? p_identification,
      Uint8List? p_doctors_note,
      String p_to_become,
      int p_tennis_club_id,
      int p_user_id) async {
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        await conn.query('CALL simple_apply_to_club(?,?,?,?,?);', [
          p_identification,
          p_doctors_note,
          p_to_become,
          p_tennis_club_id,
          p_user_id
        ]);
      }
    } catch (e) {
      throw Exception('Error creating request: $e');
    }
  }

  static Future<List<dynamic>> getMemberInfo(int guestID) async {
    List<dynamic> memberInfo = [];
    try {
      final conn = await MySQLConnector.createConnection();
      if (conn != null) {
        var result = await conn.query(
          'CALL get_user_info(?);',
          [guestID],
        );

        if (result.isNotEmpty) {
          var row = result.first;

          memberInfo = [
            row['full_name'],
            row['user_address'],
            row['user_email'],
            row['user_phone'],
            row['user_birth_date']
          ];
          await conn.close();
        } else {
          await conn.close();
          throw Exception('No guest found with the given ID');
        }
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
    return memberInfo;
  }
}
